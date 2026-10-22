--SORU 1: Kaç çağrı kaydedilmiş?
SELECT count(*)
FROM llm_calls;

--12 yani , 12 çağrı yapılmış. 
--Burada count(*) fonksiyonunun her zaman 1 satır verdiğini öğrendim ki mantıklı olanda bu sayı veriyor

--SORU 2: Kaç çağrı 2 saniyeden yavaş?
SELECT count(*)
FROM llm_calls
WHERE latency_ms > 2000;

--Benim tablodan okuduğum kadarı ile 5 tanesi yavaş şimdi çalıştırıp bakıyorum
--Tahminim doğru 5 çağrı yavaş. Aynısını bölüm 3 soru 3 de yapmıştım. 
--Orada id numaralarıyla beraber çağrılarda çıkmıştı.
--12 çağrının 5 i yavaş yani neredeyse yarısı yavaş 

--SORU 3: Toplam maliyet ve token sayısı
SELECT sum(prompt_tokens + completion_tokens) AS total_tokens, sum(cost_usd) AS total_cost
FROM llm_calls;

-- Toplam token sayısı 14.340 ve toplam maliyet 0.0631 usd çıktı. 
-- 11 id numaralı çağrının faturası yoktu ve maliyete etki etmedi
--Claude a null değerler sayılıyor mu diye sordum ve o da bana sum() fonksiyonunun
--onları hesaba katmadığını söyledi. Yani bu durumda çıkan toplam maliyet gerçek toplam maliyet değil. 
-- 11 id numaralı çağrı dahil olduğunda toplam maliyet artacaktır. 

--SORU 4:Ortalama gecikme, bir ondalık basamağa yuvarlanmış.
SELECT round(avg(latency_ms),1) AS avg_latency
FROM llm_calls;

--Ortalama gecikme 1848.3ms yani yaklaşık 2 saniye ve bu bence yeterli. 
--Ancak bunu uzatan büyük ihtimalle 4100 ms lik çağrı. 

--SORU 5: En hızlı ve en yavaş çağrı?

SELECT min(latency_ms),max(latency_ms) AS en_yavas,min(latency_ms) AS en_hizli,max(latency_ms)
FROM llm_calls;

--En hızlı çağrı 380 ms ve en yavaş çağrı 4100 ms arada yaklaşık 11 kat fark var. 

--SORU 6:Her türde kaç çağrı var ve kaç satır döndü ve neden o kadar var
SELECT task_type, count(*)
FROM llm_calls
GROUP BY task_type;

--5 satır döndü.Bu bölüm 3 soru 13 de zaten yapılmıştı oradan bakarak yaptım ama tek farkla
--GROUP BY task_type yazarak her türde kaç çağrıı olduğunu gördüm. 
--Bunlar: 3 summarize, 2 code, 2 translate, 3 chat, 2 classify çağrısı.Toplam 12 çağrı yapılmış.

--SORU 7: Her model için çağrı sayısı ve toplam maliyet, pahalıdan ucuza.
SELECT model_name, count(*), sum(cost_usd) AS total_cost
FROM llm_calls
GROUP BY model_name
ORDER BY total_cost DESC;

--7 satır döndü. En pahalı claude sonnet çıktı (0.0384) ve 2 kere kullanılmış , en ucuz ise gpt 4o mini çıktı (0.0001).
-- En ucuz çıkan gpt-4o-mini 1 kere kullanılmış.
--2.sırada olan gpt-4o 3 kez kullanılmış ama en pahalı olmamasının sebebi faturası olmayan 11 numaralı çağrı
--Bu çağrının maliyetide eklense en pahalı  gpt-4o olur. 

--SORU 8:Her kullanıcının her iş türünden kaç çağrısı var?
SELECT COALESCE(user_name, 'bilinmiyor') AS user_name, task_type, count(*)
FROM llm_calls
GROUP BY user_name, task_type;

--12 satır döndü
--1 adet boş chat çağrısı yapılmış kimden olduğu belli değil.
--Bilinmeyen kullanıcı için kutu boş kalması diye claude un tavsiyesiyle COALESCE(user_name, 'bilinmiyor') ekledim. 

--SORU 9:İkiden fazla çağrı almış modeller.
SELECT model_name, count(*)
FROM llm_calls
GROUP BY model_name
HAVING count(*) > 2;
--1 satır döndü. Bu gpt-4o ve 3 defa çağrı yapılmış. 

--SORU 10:Sadece 500 ms’den yavaş çağrıları hesaba kat; en az 2 çağrısı olan modelleri ortalama gecikmesiyle göster.
SELECT model_name, count(*), avg(latency_ms)
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING  count(*) >= 2 ;

--WHERE 2 çağrıyı attı 3 ve 9 id numaraları çağrıları 500 ms den yavaş ama 2 den fazla veya eşit kullanılmış
--HAVING 3 modeli attı gemini-flash ve gemini-pro, 1 er çağrıları olduğu için elendi , llama-3-8b ise WHERE
-- tarafından 1 çağrısı 500ms in altında olduğu için 2 çağrıdan 1 düştü ve elendi. 
-- 1 üst satırda bahsettiğimiz olay WHERE, HAVING den önce çalıştığı için oldu 
--WHERE in elediklerinden kalanları gördü sadece HAVING tam tersi olsaydı llama-3-8b HAVING den geçerdi. 

--SORU 11:NULL avı. Tek bir sorguda count(*) ile her sütunun count’unu yan yana koy.
--llm_calls tablosunda hangi sütunda kaç eksik veri var?
SELECT count(*) AS total,
       count(user_name) AS user_name_dolu,
       count(cost_usd) AS cost_dolu,
       count(model_name) AS model_names_dolu,
       count(latency_ms) AS latency_ms_dolu,
       count(task_type) AS task_type_dolu
FROM llm_calls;

--Toplam 12 çağrı var , eksik sütunlar kullanıcı adı ve fiyatta bunlardan biri anonim chat çağrısı yapılan sütun
--diğeri ise faturası kesilmemiş 11 id numaralı çağrı 
-- | Sütun      | Dolu | Eksik |
-- | user_name  | 11   | 1     |
-- | cost_usd   | 11   | 1     |
-- | diğerleri  | 12   | 0     |

--SORU 12:Faturası gelmemiş çağrıları listele.

--IS NULL ile

SELECT *
FROM llm_calls
WHERE cost_usd IS NULL;

--NULL ile

SELECT *
FROM llm_calls
WHERE cost_usd = NULL;

--IS NULL ile 1 satır döndü ama NULL ile 0 satır döndü. 
--NULL bilinmeyen birşey bilinmeyene eşit olamayacağı için satır okumuyor  0 satır dönüyor

--SORU 13:ki ortalama. Ortalamayı iki şekilde hesapla ve yan yana göster: 
--boşları atlayarak ve boşları sıfır sayarak (COALESCE).

SELECT round(avg(cost_usd),4) AS bos_atlanan,
       round(avg(COALESCE(cost_usd, 0)),4) AS bos_sifir_sayilan
FROM llm_calls;   

--1 satır döndü. Boş atlanan 0.0057, boş sıfır sayılan ise 0.0053
--Bence 11 id numaralı çağrı henüz faturası gelmemiş bir çağrı olarak kaldığı için
--onu sıfır saymak doğru değil ama faturası gelmemiş değil de bedava olsaydı mantıklıydı. 
--Bu yüzden atlayarak saymak doğru olan faturası gelmedi diye onu sıfır sayamayız. 

--SORU 14:Günlük kullanım raporu: gün, çağrı sayısı, toplam maliyet.

SELECT created_at::date AS gun,
       count(*) AS cagri_sayisi,
       sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY created_at::date
ORDER BY gun;       

--6 satır döndü.
--En çok çağrı 16 Ekimde yapılmış (5) ve toplam maliyeti 0.0053 tutmuş. 
-- O gün gpt-4o-mini, gpt-4o, gemini-pro, llama-3-8b ve claude-haiku kullanılmış. 
--Ancak fazla olmasına rağmen ucuz olmasının bir sebebi var bu faturalandırılmamış 11 numaralı çağrı
--belki de bu çağrı faturalandığı zaman maliyeti artabilir.

--SORU 15:Gecikmeye göre: Hızlı (1000 ms altı), Orta (1000–2499), 
--Yavaş (2500 ve üstü). Her kategoride kaç çağrı var ve ortalama gecikme ne?

SELECT CASE
         WHEN latency_ms < 1000 THEN 'Hizli'
         WHEN latency_ms < 2500 THEN 'Orta'
         ELSE 'Yavaş'
       END AS kategori,
       count(*) AS cagri_sayisi,
       round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls
GROUP BY kategori;

--3 satır döndü. 3 kategori 
-- Çağrılar üç kategoriye eşit dağılmış: her birinde 4 çağrı var, toplam 12.
-- Yavaş çağrıların ortalaması (3162.5 ms), hızlılarınkinin (607.5 ms) yaklaşık 5 katı.
-- Yani çağrıların üçte biri 2,5 saniyenin üstünde, kullanıcı açısından ciddi bir bekleme.
-- Soru 4'teki 1848.3 ms ortalama bu farkı gizliyordu: kategorilere bölünce
-- hızlı ve yavaş çağrıların aslında çok farklı olduğu ortaya çıkıyor.

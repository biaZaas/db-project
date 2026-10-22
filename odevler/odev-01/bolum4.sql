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
--
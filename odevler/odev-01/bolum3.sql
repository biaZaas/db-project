--SORU 1:İd ve Model adları
SELECT id, model_name
FROM llm_calls;
--12 satır döndü 

--SORU 2:MODEL ADI VE TOKEN SAYISI
SELECT model_name AS model , prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
--12 satır döndü

--SORU 3:Gecikmesi 2 saniyeyi aşan çağrılar
SELECT * 
FROM llm_calls
WHERE latency_ms > 2000;
--5 satır döndü benim tahminim ise 4 idi, 2300 lük çağrıyı gözden kaçırmışım.

--SORU 4: Ece'nin çağrıları
SELECT *
FROM llm_calls
WHERE user_name = 'Ece';
--3 satır döndü

--SORU 5:Chat dışında çağrılar
SELECT *
FROM llm_calls
WHERE task_type <> 'chat';
--9 satır döndü , chat sadece 3 satır olduğu için ve toplam 12 satır olduğu için 12-3=9 satır döndü.

--SORU 6: Claude ile yapılan 1 saniyeden yavaş çağrılar
SELECT *
FROM llm_calls
WHERE model_name LIKE 'claude%' AND latency_ms > 1000;
--2 satır döndü ancak ilk başta 0 satır döndü gözüktü çünkü 'claude' kelimesinin baş harfi büyük olduğu için doğru çalışmadı
--büyük harfi küçük harfe çevirdim ve doğru sonucu aldım.

--SORU 7: Kod veya çeviri işi 0.01 doları aşan çağrılar
SELECT *
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate') AND cost_usd > 0.01;
--3 satır döndü
--şimdi parantezi kaldırıp tekrar deniyorum
SELECT *
FROM llm_calls
WHERE task_type = 'translate' OR task_type = 'code' AND cost_usd > 0.01;
--tekrar 3 satır döndü bende bunun üzerine claude un tavsiyesi üzerine translate ile code un yerini değiştirdim ve bu sefer 
-- 4 satır döndü çünkü bu sefer şart code a döndü 

--SORU 8 : Gecikmesi 500-1500 ms arasında olan çağrılar
SELECT *
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
--3 satır döndü 

--SORU 9: Gpt'ler ile yapılar çağrılar
SELECT *
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
--4 satır döndü.

--SORU 10: Model adında mini geçen çağrılar
SELECT *
FROM llm_calls
WHERE model_name LIKE '%mini%';
--benim tahminim şuan 1 satır döneceği
--tahminim malesef yanlış çıktı 3 satır döndü sebebi ise şu ben gemini yi saymadım ben sadece gpt-4o-mini yi saydım
--claude dan aldığım bilgiye göre LİKE anlama değil harflere bakıyorumuş bu yüzden yanlış tahmin yaptım.

--SORU 11: Önce kullanıcıya sonra ise kullanıcı için maliyetine göre pahalıdan ucuza sıralama
SELECT *
FROM llm_calls
ORDER BY user_name, cost_usd DESC;
--12 satır döndü . Deniz in 11 id numaralı çağrısı en başta duruyor çünkü boş değer olduğu için onu en başa koydu 

--SORU 12: En pahalı 3 çağrı
SELECT *
FROM llm_calls
ORDER BY cost_usd DESC
NULLS LAST
LIMIT 3; 
-- 3 satır dönndü. en pahalı olan 7 id numaralı çağrı ancak ilk yazdığımda en başta boş değer çıktı
-- bende bunun üzerine limiti 4 e çıkardım ve ilk 3 ü gördüm ama sonra NULL LAST ı öğrenip ekledim

--SORU 13: Hangi iş türleri var?
SELECT DISTINCT task_type
FROM llm_calls;
-- 5 satır döndü. Bunlar: code,summarize,chat,translate,classify. 

--SORU 14: Kullanıcı adlarını Türk alfabesine göre doğru biçimde tekrarsız listele
-- COLLATE ile
SELECT DISTINCT user_name COLLATE "tr-TR-x-icu" AS user_name
FROM llm_calls
ORDER BY user_name;
---- COLLATE olmadan
SELECT DISTINCT user_name
FROM llm_calls
ORDER BY user_name;
-- İki sorgu da 6 satır döndü ve sıralama değişmedi.
-- Çünkü isimlerin baş harfleri Türkçe ve İngilizce alfabede aynı sırada.
-- 6. satır boş: 12 numaralı çağrının kullanıcısı NULL, DISTINCT onu da bir değer sayıyor.
-- İlk denemede "for SELECT DISTINCT, ORDER BY expressions must appear in select list" hatası aldım.
-- COLLATE'i ORDER BY yerine SELECT satırına taşıyınca düzeldi.

--SORU 15: 14 Ekimden sonra yapılan 1 saniyeden yavaş çağrılar , yavaştan hızlıya doğru.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at >= '2026-10-14' AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 6 satır döndü. büyükten küçüğe id numaraları şöyle: 7>4>8>10>11>6 
-- İlk denemede latency_ms > 1000 yerine < kullandım ve 3 satır döndü sonra tabloyu kontrol ettim.
--Yanlış olduğunu görünce tekrar bakınca onu düzelttim ve doğru sonuca ulaştım.

--


--SORU 1:İd ve Model adları
SELECT id, model_name
FROM llm_calls;
--12 satır döndü 

--SORU 2:MODEL ADI VE TOKEN SAYISI
SELECT model_name AS model , prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
--12 satır döndü

--SORU 3:Gecikmesi 2 sn yi aşan çağrılar
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







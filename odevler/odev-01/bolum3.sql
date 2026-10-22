--SORU 1:İd ve Model adları
SELECT id, model_name
FROM llm_calls;
--SORU 2:MODEL ADI VE TOKEN SAYISI
SELECT model_name AS model , prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;



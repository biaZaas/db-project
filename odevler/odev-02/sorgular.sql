-- =========================================
-- Ödev 2 - İsmet Paşalıoğlu - 202507131053
-- Veritabanı: robot_fleet
-- =========================================

-- Soru 1: Her robotun adı, operatör adı ve operatörün telefonu (INNER JOIN)
SELECT r.name          AS robot,
       o.operator_name AS operator,
       o.phone
FROM robots r
INNER JOIN operators o
        ON o.operator_name = r.operator_name;
-- Yorum: 9 satır döndü. Mars-03 listede yok. Çünkü operatör kolonu null bu sebeple listede yer almadı.
-- Sadece inner join ile calistirlsaydi Mars-03 hic görülmeyecekti

-- Soru 2: Aynı liste, ama bütün robotlar görünsün (LEFT JOIN)
SELECT r.name          AS robot,
       o.operator_name AS operator,
       o.phone
FROM robots r
LEFT JOIN operators o
       ON o.operator_name = r.operator_name;
-- Yorum:10 satır. Mars-03 geldi ama operatör ve telefon sütunları boş. 
-- Yani Mars-03, operators tablosunda karşılığı olan bir operatöre bağlı değil.

-- Soru 3: Hiç görev almamış robotların adı ve modeli
SELECT r.name, r.model
FROM robots r
LEFT JOIN missions m
       ON m.robot_id = r.id
WHERE m.id IS NULL;
-- Yorum: 4 robot hiç görev almamış. Bunlar Kartal-04, Kartal-02, Mars-03 ve Atlas-03.

-- Soru 4a: Görevi olan robotların toplam bataryası (JOIN ile - HATALI yöntem)
SELECT SUM(r.battery_level) AS toplam_join
FROM robots r
JOIN missions m ON m.robot_id = r.id;
-- Yorum: 700 çıktı. Birden fazla görevi olan robotun bataryası birden fazla sayıldı.
-- Örneğin Kartal-01'in bataryası 18, 3 görevi olduğu için toplama 3 kez eklendi (18 yerine 54). 

-- Soru 4b: Aynı toplam, her robot bir kez sayılarak (DOĞRU yöntem)
SELECT SUM(battery_level) AS toplam_dogru
FROM robots
WHERE id IN (SELECT robot_id FROM missions);
-- Yorum: 262 cikti. Her robot bir kez sayiliyor. Karsilastirma yaparsak 262 den 700 cikti.

-- Soru 5: Robot başına görev sayısı, görevi olmayanlar 0 görünsün
SELECT r.name, COUNT(m.id) AS gorev_sayisi
FROM robots r
LEFT JOIN missions m ON m.robot_id = r.id
GROUP BY r.id, r.name
ORDER BY gorev_sayisi DESC;
-- Yorum: 0 olan 4 robot hic gorev almamis ve toplam 14 gorev alinmis bunlarin cogunu 3'er gorevle Kartal-01, Atlas-01 ve Kartal-03 robotlari almis

-- =========================================
-- BÖLÜM 2: Kendi projem (Kura #42 - müşteri hizmetleri talepleri)
-- =========================================

-- Proje Sorusu 1: Hangi konuda kaç talep var ve ortalama yanıt süresi ne? (ana soru: hangi konu)
SELECT c.name                                  AS konu,
       COUNT(t.id)                             AS talep_sayisi,
       AVG(t.issue_responded_at - t.issue_reported_at) AS ort_yanit_suresi
FROM tickets t
JOIN categories c ON c.id = t.category_id
GROUP BY c.name
ORDER BY talep_sayisi DESC;
-- Yorum: Sorgu tasarlanan şemaya göre yazıldı; veri yeni PostgreSQL kurulumuna henüz yüklenmedi, final öncesi çalıştırılacak.

-- Proje Sorusu 2: Hangi saatte, hangi konuda talep yoğunlaşıyor? (ana soru: hangi saat aralığı)
SELECT EXTRACT(HOUR FROM t.issue_reported_at) AS saat,
       c.name                                 AS konu,
       COUNT(*)                               AS talep_sayisi
FROM tickets t
JOIN categories c ON c.id = t.category_id
GROUP BY saat, c.name
ORDER BY talep_sayisi DESC
LIMIT 10;
-- Yorum: Sorgu tasarlanan şemaya göre yazıldı; veri yeni PostgreSQL kurulumuna henüz yüklenmedi, final öncesi çalıştırılacak.
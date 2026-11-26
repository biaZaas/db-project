# Ödev 2 Raporu - JOIN, ERD ve Normalizasyon

**Ad Soyad:** İsmet Paşalıoğlu  **Öğrenci No:** 202507131053
**Repo / PR:** https://github.com/biaZaas/db-project (branch: odev-02)

## Fan-out: 4. soruda toplam kaçtan kaça çıktı?

Görevi olan robotların gerçek toplam bataryası **262**. Robots ile missions tablolarını JOIN edip topladığımda sonuç **700** çıktı. Bunun nedeni JOIN'in her görev için ayrı bir satır üretmesi: birden fazla görevi olan robotun bataryası birden fazla kez toplandı. Örneğin Kartal-01'in bataryası 18, 3 görevi olduğu için toplama 54 olarak girdi. Doğru sonucu, her robotu bir kez sayan `WHERE id IN (SELECT robot_id FROM missions)` ile aldım. Ders olarak şunu çıkardım: JOIN'den sonra SUM yapmadan önce satırların çoğalıp çoğalmadığını kontrol etmem gerekiyor.

## En zor karar: Kendi ERD'mde en çok düşündüğüm karar

Vizede planladığım `messages` tablosunu çıkarıp çıkarmamak. Senaryomda mesaj sayısını kullanmak istiyordum, ama Kaggle verimde mesaj düzeyinde kayıt yok, her satır tek bir talep. Boş kalacak bir tablo tutmak yerine onu çıkardım ve mesaj sayısı yerine yanıt süresini (`issue_responded_at - issue_reported_at`) kullandım. Ayrıca süpervizör bilgisi talebe değil temsilciye bağlı olduğu için `agents` tablosunu ayırdım (3NF).

## Ek not

Bölüm 2'deki iki JOIN sorgusu tasarladığım şemaya göre yazıldı. PostgreSQL'i bu hafta yeniden kurduğum için proje verim henüz yüklenmedi; sorguları final öncesi verimle çalıştıracağım. Ayrıca ilk commit'te sorgu dosyası kaydedilmemişti, bir sonraki commit'te ekledim.

## Yapay Zeka Beyanı

- **Araç:** Claude (Anthropic)
- **Ne için:** PostgreSQL kurulumundaki hataları (Türkçe locale, kodlama) çözmek, Git komutlarını öğrenmek, 1-5. soruların sorgu iskeleti, ERD taslağı, normalizasyon notu ve bu raporun taslağı.
- **Nasıl doğruladım:** Bütün sorguları kendi bilgisayarımda psql ile çalıştırdım. Satır sayılarını (9, 10, 4, 700, 262) kendim gördüm ve 3. ile 5. sorunun sonuçlarını birbiriyle karşılaştırdım (aynı 4 robot, toplam 14 görev). Mars-03'ün operatörünün gerçekten NULL olduğunu ayrı bir sorguyla kontrol ettim.
- **Yapay zekanın hatası:** İlk önerdiği sütun adları yanlıştı (operators tablosunda `id` olduğunu varsaymıştı). Gerçek şemayı görünce JOIN koşulunu `operator_name` ile düzelttim.
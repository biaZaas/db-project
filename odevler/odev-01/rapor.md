# Ödev Raporu

> **Bu rapor yazdırılıp derste elden teslim edilir.** Aynı dosya reponda `odevler/odev-NN/rapor.md` olarak da durur.
> Bir sayfa yeterli, en fazla iki. Bilgisayarda doldurup yazdırabilirsin, elle de doldurabilirsin.

---

**Ödev no:** Ödev _1___     **Hafta:** __1-5__     **Tarih:** __23__ / _10___ / 2026

**Ad Soyad:** ___İsmet Paşalioğlu___________________________  **Öğrenci No:** ___202507131053___________

**Program:** [X] Yapay Zeka Operatörlüğü  ☐ Robotik ve Yapay Zeka

**Kullandığım veritabanı:** [X] `llm_ops`  ☐ `robot_fleet`

**PR bağlantısı:** `https://github.com/biaZaas/db-project/pull/1'

**Commit sayısı:** 12

---

## 1. Ne yaptım

Bu ödevde neyi çözdüğünü 3-5 cümleyle anlat. Soru listesini tekrar yazma; **ne öğrendiğini** yaz.

Kodları manuel izlemeyi öğrendim.

Bölüm 3'te WHERE, LIKE, BETWEEN, ORDER BY gibi araçları öğrendim.

Bölüm 4 te gruplamayı öğrendim.

---

## 2. Sonuçlar

Çözdüğüm soru sayısı: 37 / 37     Bonus: denemedim

En zorlandığım soru: **Soru: Bölüm3 soru 14**

Neden zorlandım:

COLLATE i  nereye yazıcağımı bulamadım ve uzun bir süre çözemedim ORDER BY içine yazıyordum
______________________________________________________________________

Nasıl çözdüm:

Claude bana DISTINCT kullanınca ORDER BY da ki ifadenin SELECT te ki ile aynı olması gerektiğini söyledi bende COLLATE i SELECT satırına taşıdım çalıştı
______________________________________________________________________

---

## 3. Beklemediğim bir sonuç

Bir sorgu beklediğinden farklı sayıda satır döndürdü mü? Hangisi ve neden?

(Eksik veri, koşul önceliği, büyük/küçük harf, birim dönüşümü… Böyle bir durumla karşılaşmadıysan "karşılaşmadım" yaz, ama önce iyi bak.)

**Soru no:** karşılaşmadım

**Beklediğim:** ______ satır   **Gelen:** ______ satır

**Sebebi:**

______________________________________________________________________

______________________________________________________________________

---

## 4. Aldığım bir hata ve çözümü

Dönem boyunca hata mesajı okumayı öğreniyoruz. Bu hafta aldığın bir hatayı yaz.

**Hata mesajı:**

_________syntax error at or near "SELECT"_____________________________________________________________

**Sebebi ve çözümü:**

iki sorguyu alt alta yazdım ama ilkinin sonuna ; koymayı unuttum. PostgreSQL sorgunun bittiğini anlamadı ve ikinci SELECT’i birincinin devamı sandı. İlk sorgunun sonuna noktalı virgül ekleyince iki sorgu da çalıştı.

______________________________________________________________________

---

## 5. Yapay zeka kullanım beyanı


x☐ Kullandım, aşağıda belirttim: Kullandım

| Soru no   | Araç | Ne sordum (özet)             | Cevabı nasıl doğruladım |
|B3,B4 hepsi|claude|hangi fonksiyonların gerektiği|çalıştırdım, tabloyla karşılaştırdım
|B3S14,B4S15 |claude |yorumlama yardımı           |okudum ve kendimce doğruladım
| |          |claude | Kurulum                    |
| | | | |

> "Nasıl doğruladım" sütunu en önemlisi. "Çalıştırdım, 4 satır döndü, tabloyla karşılaştırdım" gibi somut bir şey yaz.

---## Özellikle sorulan dört konu

1. Parantez tuzağı: İlk denemede fark çıkmadı (3 ve 3), çünkü code çağrılarının hepsi zaten 0.01'den pahalıydı. Şartların sırasını değiştirince 4 satır geldi, ucuz bir çeviri çağrısı da listeye girdi. AND, OR'dan önce çalıştığı için parantez şart.
2. Türkçe sıralama:Hiçbir isim yer değiştirmedi. Ç, Ğ, İ, Ö, Ş, Ü ile başlayan bir isim olmadığı için sonuç aynı çıktı.
3. Kayıp kayıtlar: cost_usd < 0.01 ile 8, >= 0.01 ile 3 satır geldi, toplam 11. 12 numaralı çağrıdan biri kayboldu: 11 numaralı çağrının maliyeti NULL olduğu için iki şarta da girmiyor.
4. İki ortalama: Boşları atlayınca 0.0057, sıfır sayınca 0.0053 çıktı, fark 0.0004. Boşları atlayan daha dürüst, çünkü faturası gelmemiş çağrı bedava değil. Sıfır saymak ortalamayı yapay olarak düşürür.

## 6. Öz değerlendirme

Rubriğe ([RUBRIK.md](../RUBRIK.md)) göre kendine bir seviye ver. Bu puanını etkilemez.

| Ölçüt | 4 Tam | 3 İyi | 2 Gelişmeli | 1 Yetersiz |
|---|---|---|---|---|
| A, Doğruluk | ☐ | ☐ | ☐ | ☐ | 4
| B, SQL kalitesi | ☐ | ☐ | ☐ | ☐ | 3 
| C, Yorum ve analiz | ☐ | ☐ | ☐ | ☐ | 3
| D, Git ve PR disiplini | ☐ | ☐ | ☐ | ☐ | 2
| E, Dürüstlük ve beyan | ☐ | ☐ | ☐ | ☐ | 4

Bir dahaki ödevde daha iyi yapacağım şey:

__Bütün bölümleri okumadan başlamayacağım.

---

## 7. Bana sorun

Anlamadığın, merak ettiğin ya da derste tekrar görmek istediğin bir konu:
_____________________________________________________________

______________________________________________________________________

---

**İmza:** ____ismet PAŞALİOĞLU ____________________

---

*Doğruluk beyanı: Bu çalışmayı kendim yaptım. Kullandığım tüm yardımcı kaynakları ve yapay zeka araçlarını yukarıda beyan ettim.*

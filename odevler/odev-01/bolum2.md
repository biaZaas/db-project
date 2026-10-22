BÖLÜM 2

SORU 1 => Bir kurum verilerini Excel dosyalarında tutuyor. Hangi üç somut sorunla karşılaşır? Her sorunu bir veri tabanının nasıl çözdüğünü de yaz.

CEVAP 1 => 
- ilk karşılaşacağı sorun veri tekrar tekrar  aynı veriyi birden fazla dosyada kullanır. Vtys bunu bütün verileri tek bir yerde tutarak engeller.
-ikinci karşılaşabilecekleri sorun güvenlik herkes girip değiştirememeli veriyi buna vtys şöyle bir çözüm sunar; rol ve yetkiler verir herkesin rolünün veya yetkisini erişebileceği şeyleri değiştirebilir.
-üçüncü ve son olarak tutarsızlık veri bir yerde farklı başka bir yerde farklı gözükebilir bu da hangi verinin doğru olduğunu anlamayı zorlaştırır. Vtys bunu veri için kurallar koyarak (örneğin kısıt koyabilir) engeller.

SORU 2 => Birincil anahtar (primary key) ne işe yarar? Öğrenci numarası iyi bir birincil anahtar mıdır, ad soyad neden değildir?

CEVAP 2 => Satırı eşsiz tanımlar , Öğrenci numarası kendi yorumum olarak bence iyi bir primary key çünkü başka bir öğrenci aynı numarada olamaz , ama ad soyad eşsiz değil maalesef ; örnek vermek gerekirse AHMET YILMAZ adında ve soyadına sahip 2 kişi olabilir .

SORU 3 => Veritabanı yönetim sistemi (DBMS) ile veritabanının farkı nedir? PostgreSQL bunlardan hangisi?

CEVAP 3 => DBMS veriyi bir yerde güvenle tutar ve aynı anda birden fazla kişiye gösterir , Veritabanı ise verinin kendisidir ve veriyi düzenli tablolar halinde saklar .
PostgreSQL benim kendi yorumumca DBMS ye girer çünkü anladığım kadarı ile hafta 3 te ki açıklamada kullanılan lokanta benzetmesinde mutfak kısmında yer alıyor ve DBMS bu tanıma bence uyuyor onu da mutfak gibi düşünebiliriz.

SORU 4 => Aynı anda iki kişi aynı kaydı değiştirmeye kalkarsa ne olur? Bunu bir cümleyle anlat, bu konuyu Hafta 10'da açacağız.

CEVAP 4 => Son kaydedenin değiştirdiği kayıt geçerli olur.
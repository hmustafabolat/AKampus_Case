# akampus_case

# home.dart

# 1-) _HomeViewState Sınıfı:

# --> allowedList: Tanınan metinde aranacak olan kelimelerin listesi.
# --> _textRecognizer: Google ML Kit Text Recognition'ı kullanmak için bir nesne.
# --> _isBusy: İşlemin devam edip etmediğini izlemek için bir bayrak.
# --> _text: Tanınan metni saklamak için bir değişken.
# --> point: Kullanıcının puanını saklamak için bir değişken.

# 2-) dispose Metodu:
# --> _textRecognizer nesnesini kapatır.

# 3-) build Metodu:
# --> Scaffold widget'ı, uygulamanın temel yapısını oluşturur. AppBar ve GalleryView bileşenlerini içerir.
# --> GalleryView bileşeni, resim seçme veya çekme işlemlerini ve bu resimlerdeki metni tanıma işlemini gerçekleştirir.

# 4-) _processImage Metodu:
# --> Resmi işleme işlemini gerçekleştirir. Bu işlem, metni tanıma ve belirli kelimelerin kontrolünü içerir.
# --> Tanınan metin içinde belirli kelimeler bulunursa, puanı artırır veya uyarı gösterir.

# 5-) _showDialog Metodu:
# --> Uyarı iletişim kutusunu görüntüler.

# 6-) _restartImage Metodu:
# Resmi sıfırlar ve metni temizler.

# gallery_view.dart

# 1-) GalleryView Sınıfı:
# --> GalleryView bileşeni, resim gösterme işlemini ve resim seçme veya çekme işlemlerini içerir.

# 2-) _GalleryViewState Sınıfı:
# --> image: Seçilen veya çekilen resmi saklamak için bir değişken.
# --> imagePicker: Resim seçme ve çekme işlemleri için bir nesne.

# 3-) initState Metodu:
# --> imagePicker nesnesini başlatır.

# 4-) _restartImage Metodu:
# --> Resmi sıfırlar.

# 5-) build Metodu:
# --> Bir ListView içinde, seçilen veya çekilen resmi gösteren bir Image veya Icon bileşeni bulunur.
# --> İki adet ElevatedButton (Galeriden Resim Seç ve Kameradan Fotoğraf Çek) bulunur.
# --> Resim gösterme, puanı gösterme ve resmi sıfırlama işlemi gerçekleştiren düğmeler bulunur.
# --> Resmi sıfırlama işlemi, widget.resetImage() işlevi aracılığıyla home.dart dosyasındaki _restartImage işlevine iletilir.

# 6-) _getImage Metodu:
# --> Resim seçme veya çekme işlemini gerçekleştirir.

# 7-) _processFile Metodu:
# --> Seçilen veya çekilen resmi işleme işlemini gerçekleştirir.
# Analisis Runtun Waktu Jumlah Penumpang Changi Airport (Metode Peramalan)

Proyek ini dibuat untuk mata kuliah **Metode Peramalan** dan berfokus pada analisis  
jumlah penumpang bulanan di **Changi Airport (Singapura)** periode 2009–2019.  
Tujuan utama adalah mengidentifikasi pola tren dan musiman, serta membangun model peramalan  
yang dapat digunakan untuk mendukung pengambilan keputusan strategis.

## 🔹 Latar Belakang
Changi Airport merupakan salah satu hub transportasi udara tersibuk di dunia.  
Jumlah penumpang yang meningkat setiap tahun menunjukkan peran strategis Singapura  
dalam jaringan penerbangan internasional. Namun, fluktuasi jumlah penumpang yang  
dipengaruhi musim, kondisi ekonomi global, dan dinamika industri penerbangan menuntut  
adanya analisis data untuk perencanaan yang lebih baik.  

Dengan pendekatan **time series**, pola historis dapat dipahami dan tren masa depan dapat diproyeksikan.  
Hal ini memberikan wawasan berharga bagi manajemen bandara, maskapai, maupun industri penerbangan.

## 🔹 Rumusan Masalah
1. Bagaimana pola jumlah penumpang pesawat bulanan di Changi Airport (2009–2019)?  
2. Apakah terdapat komponen musiman yang signifikan?  
3. Model SARIMA apa yang paling sesuai untuk data ini?  
4. Bagaimana akurasi model dalam memprediksi jumlah penumpang?  

## 🔹 Tujuan
- Mengidentifikasi pola tren dan musiman pada data penumpang bulanan.  
- Membangun model SARIMA terbaik untuk peramalan.  
- Mengevaluasi performa model dan memberikan rekomendasi strategis.  

## 🔹 Metodologi
- **Dataset**: Data jumlah penumpang bulanan 2009–2019  
- **Metode**: Time Series Analysis (dekomposisi, ACF/PACF, SARIMA)  
- **Model Terbaik**: SARIMA (2,1,0)(0,1,1)[12]  
- **Tools**: R  

## 🔹 Hasil & Insight
- Data menunjukkan pola musiman kuat, terutama peningkatan pada bulan Maret dan Desember.  
- Model **SARIMA (2,1,0)(0,1,1)[12]** berhasil menangkap pola tren dan musiman dengan baik.  
- Hasil peramalan menunjukkan tren penumpang yang terus meningkat, meski interval prediksi melebar (ketidakpastian makin besar untuk jangka panjang).  

## 🔹 Rekomendasi
- Gunakan model SARIMA untuk peramalan jangka pendek.  
- Lakukan evaluasi dan update model secara berkala dengan data terbaru.  
- Koordinasi dengan pihak maskapai dan otoritas bandara untuk antisipasi kapasitas dan layanan.  
- Pertimbangkan teknologi analitik lanjutan (AI, Big Data) untuk mendukung pengambilan keputusan di masa depan.  

📄 [Laporan Lengkap](https://drive.google.com/file/d/1YMdNZ-sZI5be6nGwgU3Q74xj1VcBynR9/view?usp=drive_link)

# ☁️ Flutter Weather App

Ứng dụng xem thời tiết thời gian thực được xây dựng bằng **Flutter**, sử dụng kiến trúc **MVVM (Provider)** và dữ liệu từ **OpenWeatherMap API**.

> **Sinh viên thực hiện:** [Trần Văn Sỹ]  
> **Mã số sinh viên:** [2224801030285]  

---

## 🌟 Tính năng nổi bật

* **Thời tiết hiện tại:** Hiển thị nhiệt độ, mô tả thời tiết (Nắng, Mưa, Mây...) của thành phố.
* **Chi tiết nâng cao:** Tốc độ gió, Độ ẩm, Khả năng mưa, Cảm giác như (Feels like), Giờ Mặt trời mọc/lặn.
* **Dự báo thời tiết:** Danh sách dự báo các khung giờ tiếp theo (3h/lần).
* **Hình nền động:** Tự động thay đổi hình nền (Nắng, Mưa, Mây) dựa trên trạng thái thời tiết thực tế.
* **Tìm kiếm:** Tìm kiếm thông tin thời tiết của bất kỳ thành phố nào trên thế giới.
* **Làm mới (Pull-to-refresh):** Kéo xuống để cập nhật dữ liệu mới nhất.

---

## 📸 Các chức năng chính (Screenshots)

Dưới đây là hình ảnh minh họa cho các chức năng đã hoàn thiện của ứng dụng:

### 1. 🌅 Hình nền động theo thời tiết (Dynamic Background)
Giao diện tự động thay đổi hình nền dựa trên trạng thái thời tiết thực tế (Nắng, Mưa, Mây...).

| Trời Nắng (Sunny) | Trời Mưa (Rainy) | Trời Nhiều Mây (Cloudy) |
|:---:|:---:|:---:|
| <img width="426" height="982" alt="image" src="https://github.com/user-attachments/assets/9cf35c9d-d4d0-4e01-9103-4b0d0f019235" /> | <img width="415" height="988" alt="image" src="https://github.com/user-attachments/assets/7d992f84-d875-440b-8931-59a85c06bbc0" />|<img width="422" height="989" alt="image" src="https://github.com/user-attachments/assets/ffac2cbd-a157-440a-a896-2a60b00affad" />|
| *Hiển thị khi trời quang đãng* | *Hiển thị khi có mưa* | *Hiển thị khi trời âm u* |

---

### 2. 📊 Thông tin chi tiết & Dự báo (Details & Forecast)
Hiển thị đầy đủ các chỉ số nâng cao và danh sách dự báo thời tiết cho các khung giờ tiếp theo.

| Thông tin chi tiết | Danh sách dự báo |
|:---:|:---:|
| <img width="417" height="992" alt="image" src="https://github.com/user-attachments/assets/46cdfaef-9560-4ffd-9108-3524cb622805" /> | <<img width="426" height="984" alt="image" src="https://github.com/user-attachments/assets/21a7c94d-f1b6-402c-8a7e-ed05635f3ac6" /> |
| *Gió, Ẩm, Mưa, Cảm giác như, Mọc/Lặn* | *Dự báo thời tiết 3h/lần ngang* |

---

### 3. 🔍 Tìm kiếm thành phố (Search City)
Cho phép người dùng nhập tên thành phố bất kỳ để xem thời tiết.

| Hộp thoại Tìm kiếm | Kết quả sau tìm kiếm |
|:---:|:---:|
| <img width="421" height="987" alt="image" src="https://github.com/user-attachments/assets/e47dfe83-5bed-4a74-9acb-49b0b7003810" /> | <img width="423" height="995" alt="image" src="https://github.com/user-attachments/assets/490ba8ce-e375-4e63-b621-532f0683fba1" /> |
| *Nhập tên thành phố (VD em nhập : LonDon)* | *Dữ liệu được cập nhật ngay lập tức* |

---

## 📂 Cấu trúc dự án

Dự án được tổ chức theo mô hình phân lớp rõ ràng để dễ bảo trì và mở rộng:

```text
lib/
├── config/              # Chứa các cấu hình chung
│   └── api_config.dart  # API Key và các đường dẫn Endpoint
│
├── models/              # Định nghĩa dữ liệu (Data Models)
│   └── weather_model.dart # Chứa các trường dữ liệu: temp, wind, sunrise...
│
├── providers/           # Quản lý trạng thái (State Management)
│   └── weather_provider.dart # Gọi API và thông báo cho UI cập nhật
│
├── screens/             # Giao diện người dùng (UI)
│   └── home_screen.dart # Màn hình chính hiển thị thời tiết
│
├── services/            # Xử lý logic gọi mạng (Networking)
│   └── weather_service.dart # Gửi request đến OpenWeatherMap
│
└── main.dart            # File chạy chính của ứng dụng

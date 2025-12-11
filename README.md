# ☁️ Flutter Weather App

Ứng dụng xem thời tiết thời gian thực được xây dựng bằng **Flutter**, sử dụng kiến trúc **MVVM (Provider)** và dữ liệu từ **OpenWeatherMap API**.

> **Sinh viên thực hiện:** [Tên Của Bạn]  
> **Mã số sinh viên:** [MSSV Của Bạn]  
> **Lớp:** [Tên Lớp]

---

## 🌟 Tính năng nổi bật

* **Thời tiết hiện tại:** Hiển thị nhiệt độ, mô tả thời tiết (Nắng, Mưa, Mây...) của thành phố.
* **Chi tiết nâng cao:** Tốc độ gió, Độ ẩm, Khả năng mưa, Cảm giác như (Feels like), Giờ Mặt trời mọc/lặn.
* **Dự báo thời tiết:** Danh sách dự báo các khung giờ tiếp theo (3h/lần).
* **Hình nền động:** Tự động thay đổi hình nền (Nắng, Mưa, Mây) dựa trên trạng thái thời tiết thực tế.
* **Tìm kiếm:** Tìm kiếm thông tin thời tiết của bất kỳ thành phố nào trên thế giới.
* **Làm mới (Pull-to-refresh):** Kéo xuống để cập nhật dữ liệu mới nhất.

---

## 📸 Hình ảnh minh họa (Screenshots)

| Màn hình chính (Nắng) | Màn hình chính (Mưa) | Tìm kiếm & Chi tiết |
|:---:|:---:|:---:|
| <img src="screenshots/home_sunny.png" width="250"> | <img src="screenshots/home_rainy.png" width="250"> | <img src="screenshots/details.png" width="250"> |

*(Lưu ý: Bạn cần thay thế đường dẫn ảnh trong thư mục screenshots tương ứng)*

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

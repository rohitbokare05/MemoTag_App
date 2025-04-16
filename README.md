# 🧠 MemoTag - Dementia Care Dashboard App

MemoTag is a doctor-facing mobile application developed using **Flutter** to assist caregivers and doctors in monitoring dementia patients’ cognitive and physical health trends. The app offers a highly visual, intuitive, and interactive UI with support for **dark mode**, **data visualization**, and **voice assistant-style suggestions**.

---

## 🚀 Features

### ✅ Dashboard
- Displays a **list of patients** with name, age, and real-time health status (Stable / Alert / Critical).
- Status is color-coded:
  - 🟢 Stable: `#25D366`
  - 🟠 Alert: `#FFA500`
  - 🔴 Critical: `#FF3B30`
- Includes a **search bar** for quickly locating patients.
- **Pull-to-refresh** implemented via `RefreshIndicator`.

### 🧑‍⚕️ Profile Screen
- Displays doctor’s name, profile image, and contact info.
- Gradient circular avatar with Hero animation.
- Clean white card layout for:
  - Email
  - Phone
  - Clinic address
- Navigation back to dashboard via button.

### 📊 Patient Detail View
- Tabs for:
  - **Cognitive Health**
  - **Physical Health**
- Each tab includes multiple KPI cards with animation and styling.

#### Cognitive KPIs
- **Memory Recall** – animated circular progress indicator.
- **Verbal Fluency** – large bold number with change indication.
- **Hesitation Rate** – vertical bar indicating performance.
- **Sentence Complexity** – custom segmented bar (`Basic → Moderate → Rich`).
- **Mood Trend** – emoji + line chart visualization.
- **Session Completion** – animated donut chart.

#### Physical KPIs
- **Sleep Hours** – animated bar chart.
- **Heart Rate** – radial gauge with animation.
- **GPS Activity** – gradient card with status.
- **Emergency & Fall Alerts** – colored gradient alert cards.
- **Step Count** – animated circular counter.

### 🌙 Dark Mode Toggle
- Fully integrated using `ValueNotifier<ThemeMode>`.
- Toggle available on:
  - Dashboard
  - Notifications
- Dark colors follow:
  - Background: `#000000`
  - Card/Text: `#FFFFFF` and `#B0B0B0`
  - Buttons retain primary blue color.

### 🎙️ Voice Assistant Popup
- Floating Action Button labeled **"Ask Memo"**.
- On tap, shows modal bottom sheet with suggestions (mock UI).

### 🔔 Notifications
- Real-time alert screen with swipe-to-dismiss.
- Includes pull-to-refresh and animation.
- Styled cards with status icons and shadows.

---

## 🎨 Theme & Colors

| Element                | Light Theme         | Dark Theme           |
|------------------------|---------------------|----------------------|
| Primary Color          | `#0057FF`           | `#0057FF`            |
| Accent (FAB/Buttons)   | `#0B5FFF`           | `#0B5FFF`            |
| Background             | `#F7F9FA`           | `#000000`            |
| Card Background        | `#FFFFFF`           | `#1E1E1E`            |
| Heading Text           | `#2D2D2D`           | `#FFFFFF`            |
| Subtext                | `#4A4A4A`           | `#B0B0B0`            |
| Search Box BG          | `#FFFFFF`           | `#1C1C1C`            |
| Mood Chart Color       | `#0B5FFF`           | `#0B5FFF`            |

---

## 📌 To-Do & Future Enhancements
- Integrate backend API for real patient data.
- Implement real-time alerts using Firebase Cloud Messaging.
- Add audio input support for Ask Memo voice assistant.
- Upload and visualize PDF reports from patients.

---
## 📱 Screenshots

### Dashboard & Themes
![Light Mode](screenshots/light_dashboard.png)
![Dark Mode](screenshots/dark_dashboard.png)

### Cognitive Health KPIs
![Cognitive KPIs](screenshots/cognitive_kpi.png)

---

## 🔗 Demo

🎬 **Watch the demo video here**:  
[https://youtube.com/shorts/jlUudTlOHXQ?si=QY0fUSjIHXCTvTl7](https://youtube.com/shorts/jlUudTlOHXQ?si=QY0fUSjIHXCTvTl7)

[![Watch Demo](https://img.youtube.com/vi/jlUudTlOHXQ/0.jpg)](https://youtube.com/shorts/jlUudTlOHXQ?si=QY0fUSjIHXCTvTl7)


## 🙌 Acknowledgements
Built as part of an internship submission task. Designed with care and attention to accessibility and UX for the elderly care domain.

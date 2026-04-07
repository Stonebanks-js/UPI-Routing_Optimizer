# 🚀 Smart UPI Routing Optimizer

> A decision intelligence layer that recommends the best-performing UPI app
> (Google Pay, PhonePe, Paytm) based on real-time success rates and latency data.

---

## 📖 Overview

Smart UPI Routing Optimizer is **not** a payment processor. It sits on top of
UPI and tracks transaction metadata (success/failure, latency, timestamps, app
name) to recommend the most reliable UPI app to the user at any given moment.

### Key Features

- **Real-time recommendations** — scores each UPI app based on recent success
  rates and latency
- **Peak-hour awareness** — adjusts scoring during high-traffic windows
  (8–10 PM IST)
- **Transaction logging** — records every payment attempt's outcome for
  continuous learning
- **Performance dashboard** — visualizes success rates and trends per app
- **No sensitive data** — only metadata is stored; no account numbers, UPI PINs,
  or financial details

---

## 🏗️ Architecture

```
┌─────────────┐       ┌──────────────────┐       ┌────────────┐
│  Flutter App │ ───▶  │  FastAPI Backend  │ ───▶  │ PostgreSQL │
│  (Android)   │ ◀──── │  (Python 3.11+)  │ ◀──── │  Database  │
└─────────────┘       └──────────────────┘       └────────────┘
```

| Layer    | Stack                         |
|----------|-------------------------------|
| Mobile   | Flutter (Dart) — Android first |
| Backend  | FastAPI + SQLAlchemy           |
| Database | PostgreSQL 15                  |
| DevOps   | Docker Compose (local dev)     |
| Hosting  | Railway.app (prod backend)     |

---

## 🚀 Getting Started

### Prerequisites

- Python 3.11+
- Flutter SDK 3.x
- Docker & Docker Compose
- PostgreSQL 15 (via Docker)

### Local Development

```bash
# 1. Clone the repo
git clone https://github.com/your-username/smart-upi-optimizer.git
cd smart-upi-optimizer

# 2. Start the database and backend
docker-compose up --build

# 3. Run the Flutter app (in a separate terminal)
cd app
flutter pub get
flutter run
```

### Environment Variables

Copy the example env file and fill in your values:

```bash
cp backend/.env.example backend/.env
```

---

## 📂 Project Structure

```
smart-upi-optimizer/
├── database/        ← SQL schema & seed data
├── backend/         ← FastAPI application
│   ├── routers/     ← API endpoints
│   ├── engine/      ← Recommendation & scoring logic
│   ├── models/      ← Pydantic schemas
│   └── db/          ← Database connection & queries
└── app/             ← Flutter mobile application
    └── lib/
        ├── screens/   ← UI screens
        ├── widgets/   ← Reusable UI components
        ├── services/  ← API calls & UPI launching
        ├── models/    ← Dart data models
        └── utils/     ← Constants & helpers
```

---

## 🇮🇳 India-Specific Context

This project targets the Indian UPI ecosystem:
- **Supported UPI apps:** Google Pay, PhonePe, Paytm
- **Peak hours:** 8:00 PM – 10:00 PM IST (highest UPI traffic)
- **Compliance:** No sensitive financial data is stored — only transaction
  metadata (success/fail, latency, timestamp, app name)

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request.

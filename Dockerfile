# استخدام نسخة Debian عشان تدعم الجافا والنود بسهولة
FROM node:20-bullseye

# ١. تثبيت الجافا والأدوات اللازمة
RUN apt-get update && apt-get install -y openjdk-17-jre-headless wget && apt-get clean

WORKDIR /app

# ٢. تحميل ملف Lavalink v4
RUN wget https://github.com/lavalink-devs/Lavalink/releases/download/4.0.8/Lavalink.jar

# ٣. تثبيت المكتبات (نحن ولدنا الـ package-lock قبل كدة)
COPY package*.json ./
RUN npm install --omit=dev

# ٤. نسخ سورس البوت
COPY . .

# ٥. تشغيل اللافالينك والبوت سوا
# عطينا اللافالينك 90 جيجا رام وسيبنا 10 جيجا للبوت
CMD java -Xmx90G -jar Lavalink.jar & node src/index.js

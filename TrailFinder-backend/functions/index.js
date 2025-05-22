require("dotenv").config(); // Optional if using .env locally

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.SENDER_EMAIL || "trailfinder.appdev2d@gmail.com",
    pass: process.env.APP_PASSWORD || "tljkjypbriydyzbv", // Use an App Password
  },
});

exports.sendOTPEmail = functions.https.onCall(async (data, context) => {
  const { email } = data;

  if (!email || typeof email !== "string") {
    return { success: false, error: "Invalid email address." };
  }

  const otp = Math.floor(100000 + Math.random() * 900000);

  const mailOptions = {
    from: `"Trailfinder" <${process.env.SENDER_EMAIL || "trailfinder.appdev2d@gmail.com"}>`,
    to: email,
    subject: "Your OTP Code",
    text: `Your OTP code is: ${otp}. It will expire in 5 minutes.`,
  };

  try {
    // Send the OTP email
    await transporter.sendMail(mailOptions);
    console.log(`OTP sent to ${email}: ${otp}`);

    // Store OTP in Firestore for validation
    const db = admin.firestore();
    await db.collection("otps").doc(email).set({
      otp,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt: Date.now() + 5 * 60 * 1000, // 5 minutes
    });

    return { success: true, message: "OTP sent successfully!" };
  } catch (error) {
    console.error("Error sending OTP email:", error);
    return { success: false, error: "Failed to send OTP. Try again later." };
  }
});




const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "trailfinder.appdev2d@gmail.com", // Your sender email
    pass: "Tr@!LF!nD3r#2D", // Use an App Password (not your main password)
  },
});

exports.sendOTP = functions.https.onCall(async (data, context) => {
  const { email } = data;

  // Generate a random 6-digit OTP
  const otp = Math.floor(100000 + Math.random() * 900000);

  const mailOptions = {
    from: "trailfinder.appdev2d@gmail.com",
    to: email,
    subject: "Your OTP Code",
    text: `Your OTP code is: ${otp}. It will expire in 5 minutes.`,
  };

  try {
    await transporter.sendMail(mailOptions);

    // Store the OTP in Firestore (optional, for validation later)
    const db = admin.firestore();
    await db.collection("otps").doc(email).set({
      otp,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt: Date.now() + 5 * 60 * 1000, // OTP expires in 5 minutes
    });

    return { success: true, message: "OTP sent successfully!" };
  } catch (error) {
    return { success: false, error: error.message };
  }
});



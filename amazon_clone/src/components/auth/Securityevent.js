// import React, { useState } from "react";
// import { logSecurityEvent } from "./securityLogger";

// const SecurityEventLogger = () => {
//   const [username, setUsername] = useState("");
//   const [responseMessage, setResponseMessage] = useState("");

//   const logEvent = async (eventType) => {
//     try {
//       const details = eventType === "auth_failure" 
//         ? "Failed login attempt detected." 
//         : "User signed in successfully.";
//       const message = await logSecurityEvent(eventType, username, details);
//       setResponseMessage(message);
//     } catch (error) {
//       setResponseMessage(error.message);
//     }
//   };

//   return (
//     <div style={{ padding: "20px", marginBottom: "20px", border: "1px solid #ddd" }}>
//       <h2>Log Security Events</h2>
//       <input
//         type="text"
//         value={username}
//         onChange={(e) => setUsername(e.target.value)}
//         placeholder="Enter username"
//         style={{ padding: "8px", marginRight: "10px", width: "300px" }}
//       />
//       <button onClick={() => logEvent("signin")} style={{ padding: "8px 16px", marginRight: "10px" }}>
//         Log Sign-in Event
//       </button>
//       <button onClick={() => logEvent("auth_failure")} style={{ padding: "8px 16px" }}>
//         Log Auth Failure Event
//       </button>
//       {responseMessage && <p>{responseMessage}</p>}
//     </div>
//   );
// };

// export default SecurityEventLogger;
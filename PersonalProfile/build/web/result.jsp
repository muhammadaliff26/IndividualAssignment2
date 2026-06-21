<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String fullName = (String) request.getAttribute("fullName");
    String studentId = (String) request.getAttribute("studentId");
    String program = (String) request.getAttribute("program");
    String email = (String) request.getAttribute("email");
    String hobbies = (String) request.getAttribute("hobbies");
    String introduction = (String) request.getAttribute("introduction");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Result</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); min-height: 100vh; display: flex; flex-direction: column; }
        nav { display: flex; justify-content: space-between; align-items: center; padding: 20px 40px; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .nav-brand { color: #ffffff; font-size: 1.1rem; font-weight: 600; text-decoration: none; }
        .nav-links { display: flex; gap: 25px; list-style: none; }
        .nav-links a { color: rgba(255, 255, 255, 0.6); text-decoration: none; font-size: 0.9rem; transition: color 0.2s; }
        .nav-links a.active, .nav-links a:hover { color: #e94560; }
        .main-content { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 20px; }
        .success-message { background: rgba(76, 175, 80, 0.2); border: 1px solid #4CAF50; border-radius: 10px; padding: 15px 20px; margin-bottom: 25px; color: #4CAF50; font-size: 0.9rem; display: flex; align-items: center; gap: 10px; }
        .error-message { background: rgba(244, 67, 54, 0.2); border: 1px solid #f44336; border-radius: 10px; padding: 15px 20px; margin-bottom: 25px; color: #f44336; font-size: 0.9rem; display: flex; align-items: center; gap: 10px; }
        .profile-container { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 20px; padding: 40px; width: 100%; max-width: 550px; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4); }
        .profile-header { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .profile-header h1 { color: #ffffff; font-size: 1.8rem; font-weight: 600; }
        .profile-header p { color: rgba(255, 255, 255, 0.5); font-size: 0.85rem; margin-top: 5px; }
        .profile-item { display: flex; flex-direction: column; margin-bottom: 18px; padding-bottom: 18px; border-bottom: 1px solid rgba(255, 255, 255, 0.07); }
        .profile-item:last-of-type { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .field-label { color: #e94560; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 4px; }
        .field-value { color: #ffffff; font-size: 0.95rem; font-weight: 300; line-height: 1.5; }
        footer { text-align: center; padding: 20px; color: rgba(255, 255, 255, 0.25); font-size: 0.78rem; border-top: 1px solid rgba(255, 255, 255, 0.07); }
        .button-group { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 25px; }
        .btn { padding: 12px 20px; font-family: 'Poppins', sans-serif; font-size: 0.9rem; font-weight: 600; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; transition: transform 0.2s, box-shadow 0.2s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-primary { grid-column: span 2; background: linear-gradient(135deg, #e94560, #c62a47); color: #ffffff; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(233, 69, 96, 0.5); }
        .btn-secondary { background: rgba(255, 255, 255, 0.1); color: #ffffff; border: 1px solid rgba(255, 255, 255, 0.3); }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.15); border-color: #e94560; color: #e94560; }
        
        @media (max-width: 480px) { 
            .profile-container { padding: 25px 20px; } 
            .profile-header h1 { font-size: 1.4rem; } 
            nav { padding: 15px 20px; } 
            .button-group { grid-template-columns: 1fr; } 
            .btn-primary { grid-column: span 1; } 
        }
    </style>
</head>
<body>
    <nav>
        <a href="index.html" class="nav-brand">Profile Management System</a>
        <ul class="nav-links">
            <li><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="form.html" class="active">Profile Form</a></li>
            <li><a href="viewProfiles.jsp">View Profiles</a></li>
        </ul>
    </nav>
    <div class="main-content">
        <div class="profile-container">
            <% if (message != null && !message.isEmpty()) { %>
                <% if (message.contains("Error")) { %>
                    <div class="error-message"><i class="fas fa-exclamation-circle"></i><%= message %></div>
                <% } else { %>
                    <div class="success-message"><i class="fas fa-check-circle"></i><%= message %></div>
                <% } %>
            <% } %>
            <div class="profile-header">
                <h1>Profile Summary</h1>
                <p>Your profile information</p>
            </div>
            <div class="profile-item">
                <span class="field-label">Full Name</span>
                <span class="field-value"><%= fullName %></span>
            </div>
            <div class="profile-item">
                <span class="field-label">Student ID</span>
                <span class="field-value"><%= studentId %></span>
            </div>
            <div class="profile-item">
                <span class="field-label">Programme</span>
                <span class="field-value"><%= program %></span>
            </div>
            <div class="profile-item">
                <span class="field-label">Email Address</span>
                <span class="field-value"><%= email %></span>
            </div>
            <div class="profile-item">
                <span class="field-label">Hobbies</span>
                <span class="field-value"><%= hobbies %></span>
            </div>
            <div class="profile-item">
                <span class="field-label">About Me</span>
                <span class="field-value"><%= introduction %></span>
            </div>
            <div class="button-group">
                <a href="form.html" class="btn btn-primary"><i class="fas fa-plus"></i> Add Another Profile</a>
                <a href="viewProfiles.jsp" class="btn btn-secondary"><i class="fas fa-list"></i> View All Profiles</a>
                <a href="index.html" class="btn btn-secondary"><i class="fas fa-home"></i> Back to Home</a>
            </div>
        </div>
    </div>
            
    <footer>&copy; 2026 Profile Management System &mdash; CSC584 Enterprise Programming</footer>
    
</body>
</html>
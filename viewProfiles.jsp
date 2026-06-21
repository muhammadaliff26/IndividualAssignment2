<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Profile.ProfileBean" %>
<%@ page import="Profile.DatabaseConnection" %>
<%@ page import="java.util.List" %>

<%
    List<ProfileBean> profiles = DatabaseConnection.getAllProfiles();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profiles</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-brand {
            color: #ffffff;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 25px;
            list-style: none;
        }

        .nav-links a {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s;
        }

        .nav-links a.active,
        .nav-links a:hover {
            color: #e94560;
        }

        .main-content {
            flex: 1;
            padding: 40px 20px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .page-header h1 {
            color: #ffffff;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 25px;
            background: linear-gradient(135deg, #e94560, #c62a47);
            color: #ffffff;
            text-decoration: none;
            border: none;
            border-radius: 10px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(233, 69, 96, 0.5);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: #e94560;
            color: #e94560;
        }

        .table-container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table thead {
            background: rgba(233, 69, 96, 0.15);
            border-bottom: 2px solid rgba(233, 69, 96, 0.3);
        }

        table th {
            color: #e94560;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        table td {
            color: rgba(255, 255, 255, 0.7);
            padding: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.07);
            font-size: 0.9rem;
        }

        table tbody tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }

        table tbody tr:last-child td {
            border-bottom: none;
        }

        .hobby-tag {
            display: inline-block;
            background: rgba(233, 69, 96, 0.2);
            color: #e94560;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            margin: 2px 2px 2px 0;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.5);
        }

        .empty-state .icon {
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.3);
            margin-bottom: 20px;
        }

        .empty-state h2 {
            color: #ffffff;
            margin-bottom: 10px;
        }

        .profile-count {
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
            padding: 20px;
            background: rgba(255, 255, 255, 0.02);
            border-top: 1px solid rgba(255, 255, 255, 0.07);
        }
        
        footer {
            text-align: center; 
            padding: 20px; 
            color: rgba(255, 255, 255, 0.25); 
            font-size: 0.78rem; 
            border-top: 1px solid rgba(255, 255, 255, 0.07); 
        }

        @media (max-width: 768px) {
            table {
                font-size: 0.85rem;
            }

            table th, table td {
                padding: 10px 8px;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <nav>
        <a class="nav-brand">Profile Management System</a>
        <ul class="nav-links">
            <li><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="form.html">Profile Form</a></li>
            <li><a href="viewProfiles.jsp" class="active">View Profiles</a></li>
        </ul>
    </nav>

    <div class="main-content">

        <div class="page-header">
            <h1>All Student Profiles</h1>
            <p>View all saved profiles in the database</p>
        </div>

        <div class="action-buttons">
            <a href="form.html" class="btn">
                <i class="fas fa-plus"></i> Add New Profile
            </a>
            <a href="searchProfiles.jsp" class="btn btn-secondary">
                <i class="fas fa-search"></i> Search & Filter
            </a>
        </div>

        <div class="table-container">

            <%
                if (profiles != null && profiles.size() > 0) {
            %>

            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Programme</th>
                            <th>Email</th>
                            <th>Hobbies</th>
                            <th>Introduction</th> </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ProfileBean profile : profiles) {
                        %>
                        <tr>
                            <td><strong><%= profile.getStudentID() %></strong></td>
                            <td><%= profile.getName() %></td>
                            <td><%= profile.getProgramme() %></td>
                            <td><%= profile.getEmail() %></td>
                            <td>
                                <%
                                    String hobbies = profile.getHobbies();
                                    if (hobbies != null && !hobbies.isEmpty()) {
                                        String[] hobbyArray = hobbies.split(", ");
                                        for (String hobby : hobbyArray) {
                                %>
                                <span class="hobby-tag"><%= hobby.trim() %></span>
                                <%
                                        }
                                    }
                                %>
                            </td>
                            <td><%= profile.getIntroduction() %></td> </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="profile-count">
                <strong><%= profiles.size() %></strong> profile<%= profiles.size() != 1 ? "s" : "" %> found in database
            </div>

            <%
                } else {
            %>

            <div class="empty-state">
                <div class="icon">
                    <i class="fas fa-inbox"></i>
                </div>
                <h2>No Profiles Found</h2>
                <p>There are no student profiles in the database yet.</p>
                <br>
            </div>

            <%
                }
            %>

        </div>

    </div>
            
            <footer>&copy; 2026 Personal Profile App &mdash; CSC584 Enterprise Programming</footer>

</body>
</html>

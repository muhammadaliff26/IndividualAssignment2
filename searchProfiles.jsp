<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Profile.ProfileBean" %>
<%@ page import="Profile.DatabaseConnection" %>
<%@ page import="java.util.List" %>

<%
    // Get search and filter parameters from the form
    String searchType = request.getParameter("searchType");  // "id" or "name"
    String searchValue = request.getParameter("searchValue");
    String filterType = request.getParameter("filterType");  // "programme" or "hobby"
    String filterValue = request.getParameter("filterValue");
    
    List<ProfileBean> results = null;
    String resultMessage = "";
    boolean hasSearched = false;

    // ── SEARCH FUNCTIONALITY ────────────────────────────────
    if (searchType != null && !searchType.isEmpty() && searchValue != null && !searchValue.trim().isEmpty()) {
        hasSearched = true;
        
        if ("id".equals(searchType)) {
            // Search by Student ID
            ProfileBean profile = DatabaseConnection.searchByStudentID(searchValue.trim());
            results = new java.util.ArrayList<ProfileBean>(); // Explicit type declaration for Java 1.5 compatibility
            if (profile != null) {
                results.add(profile);
                resultMessage = "Found 1 profile with Student ID: " + searchValue;
            } else {
                resultMessage = "No profile found with Student ID: " + searchValue;
            }
        } else if ("name".equals(searchType)) {
            // Search by Name (partial match)
            results = DatabaseConnection.searchByName(searchValue.trim());
            if (results != null && results.size() > 0) {
                resultMessage = "Found " + results.size() + " profile(s) matching name: " + searchValue;
            } else {
                resultMessage = "No profiles found matching name: " + searchValue;
            }
        }
    }
    // ── FILTER FUNCTIONALITY ────────────────────────────────
    else if (filterType != null && !filterType.isEmpty() && filterValue != null && !filterValue.isEmpty()) {
        hasSearched = true;
        
        if ("programme".equals(filterType)) {
            // Filter by Programme
            results = DatabaseConnection.filterByProgramme(filterValue);
            if (results != null && results.size() > 0) {
                resultMessage = "Found " + results.size() + " student(s) in " + filterValue;
            } else {
                resultMessage = "No students found in programme: " + filterValue;
            }
        } else if ("hobby".equals(filterType)) {
            // Filter by Hobby
            results = DatabaseConnection.filterByHobby(filterValue);
            if (results != null && results.size() > 0) {
                resultMessage = "Found " + results.size() + " student(s) with hobby: " + filterValue;
            } else {
                resultMessage = "No students found with hobby: " + filterValue;
            }
        }
    }

    // Extract all unique programmes for the dropdown filter option
    List<String> programmes = new java.util.ArrayList<String>(); // Explicit type declaration
    List<ProfileBean> allProfiles = DatabaseConnection.getAllProfiles();
    if (allProfiles != null) {
        for (ProfileBean p : allProfiles) {
            if (p.getProgramme() != null && !programmes.contains(p.getProgramme())) {
                programmes.add(p.getProgramme());
            }
        }
    }
    java.util.Collections.sort(programmes);

    // Extract all unique hobbies for the dropdown filter option
    List<String> hobbies = new java.util.ArrayList<String>(); // Explicit type declaration
    if (allProfiles != null) {
        for (ProfileBean p : allProfiles) {
            String hobbyStr = p.getHobbies();
            if (hobbyStr != null && !hobbyStr.isEmpty()) {
                String[] hobbyArray = hobbyStr.split(", ");
                for (String hobby : hobbyArray) {
                    if (!hobbies.contains(hobby.trim())) {
                        hobbies.add(hobby.trim());
                    }
                }
            }
        }
    }
    java.util.Collections.sort(hobbies);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search & Filter Profiles</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* ── Reset & Base Styles ── */
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

        /* ── Navigation Bar ── */
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

        /* ── Layout Panels ── */
        .main-content {
            flex: 1;
            padding: 40px 20px;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
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

        .search-filter-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 40px;
        }

        @media (max-width: 768px) {
            .search-filter-wrapper {
                grid-template-columns: 1fr;
            }
        }

        .search-box, .filter-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }

        .search-box h2, .filter-box h2 {
            color: #e94560;
            font-size: 1.1rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            color: rgba(255, 255, 255, 0.75);
            font-size: 0.85rem;
            margin-bottom: 7px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #e94560;
            outline: none;
        }

        .form-group select option {
            background-color: #16213e;
            color: #ffffff;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #e94560, #c62a47);
            color: #ffffff;
            border: none;
            border-radius: 10px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(233, 69, 96, 0.5);
        }

        /* ── Results Panel Styles ── */
        .results-section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            margin-top: 20px;
        }

        .results-header {
            background: rgba(233, 69, 96, 0.15);
            border-bottom: 2px solid rgba(233, 69, 96, 0.3);
            padding: 20px 25px;
        }

        .results-header h3 {
            color: #e94560;
            font-size: 1rem;
            margin-bottom: 5px;
        }

        .results-header p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.85rem;
        }

        .results-table {
            width: 100%;
            border-collapse: collapse;
        }

        .results-table thead {
            background: rgba(233, 69, 96, 0.1);
        }

        .results-table th {
            color: #e94560;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .results-table td {
            color: rgba(255, 255, 255, 0.7);
            padding: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.07);
            font-size: 0.9rem;
        }

        .results-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.02);
        }

        .hobby-tag {
            display: inline-block;
            background: rgba(233, 69, 96, 0.15);
            color: #e94560;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin: 2px;
            border: 1px solid rgba(233, 69, 96, 0.3);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: rgba(255, 255, 255, 0.5);
        }

        /* ── Footer Styling ── */
        footer {
            text-align: center; 
            padding: 20px; 
            color: rgba(255, 255, 255, 0.25); 
            font-size: 0.78rem; 
            border-top: 1px solid rgba(255, 255, 255, 0.07); 
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
            <li><a href="viewProfiles.jsp">View Profiles</a></li>
        </ul>
    </nav>

    <div class="main-content">
        <div class="container">

            <div class="page-header">
                <h1>Search or Filter Profiles</h1>
                <p>Find student profiles using search or filter options</p>
            </div>

            <div class="search-filter-wrapper">

                <div class="search-box">
                    <h2><i class="fas fa-search"></i> Search Profile</h2>
                    <form method="GET" action="searchProfiles.jsp">
                        
                        <div class="form-group">
                            <label>Search By:</label>
                            <select name="searchType" required>
                                <option value="">Select search type</option>
                                <option value="id">Student ID</option>
                                <option value="name">Name</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Enter Value:</label>
                            <input type="text" name="searchValue" placeholder="e.g. 2023001 or Ahmad" required>
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </form>
                </div>

                <div class="filter-box">
                    <h2><i class="fas fa-filter"></i> Filter Profile</h2>
                    <form method="GET" action="searchProfiles.jsp">
                        
                        <div class="form-group">
                            <label>Filter By:</label>
                            <select name="filterType" required>
                                <option value="">Select filter type</option>
                                <option value="programme">Programme</option>
                                <option value="hobby">Hobby</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Select Value:</label>
                            <select name="filterValue" required>
                                <option value="">Choose...</option>
                            </select>
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fas fa-filter"></i> Filter
                        </button>
                    </form>
                </div>

            </div>

            <% if (hasSearched) { %>
                <div class="results-section">
                    <div class="results-header">
                        <h3>Search Results</h3>
                        <p><%= resultMessage %></p>
                    </div>

                    <% if (results != null && results.size() > 0) { %>
                        <div style="overflow-x: auto;">
                            <table class="results-table">
                                <thead>
                                    <tr>
                                        <th>Student ID</th>
                                        <th>Name</th>
                                        <th>Programme</th>
                                        <th>Email</th>
                                        <th>Hobbies</th>
                                        <th>Introduction</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (ProfileBean profile : results) { %>
                                        <tr>
                                            <td><strong><%= profile.getStudentID() %></strong></td>
                                            <td><%= profile.getName() %></td>
                                            <td><%= profile.getProgramme() %></td>
                                            <td><%= profile.getEmail() %></td>
                                            <td>
                                                <%
                                                    String itemHobbies = profile.getHobbies();
                                                    if (itemHobbies != null && !itemHobbies.isEmpty()) {
                                                        String[] hobbyArray = itemHobbies.split(", ");
                                                        for (String hobby : hobbyArray) {
                                                %>
                                                            <span class="hobby-tag"><%= hobby.trim() %></span>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </td>
                                            <td><%= profile.getIntroduction() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="empty-state">
                            <i class="fas fa-folder-open" style="font-size: 2rem; margin-bottom: 10px; color: #e94560;"></i>
                            <p>No matches found in the system matching criteria.</p>
                        </div>
                    <% } %>
                </div>
            <% } %>

        </div>
    </div>

    <footer>
        &copy; 2026 Personal Profile App &mdash; CSC584 Enterprise Programming: Individual Assignment
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const filterTypeSelect = document.querySelector('select[name="filterType"]');
            const filterValueSelect = document.querySelector('select[name="filterValue"]');

            // Arrays built dynamically from Java Database Lists
            const programmes = [
                <% for (int i = 0; i < programmes.size(); i++) { %>
                    '<%= programmes.get(i).replace("'", "\\'") %>'<%= i < programmes.size() - 1 ? "," : "" %>
                <% } %>
            ];

            const hobbies = [
                <% for (int i = 0; i < hobbies.size(); i++) { %>
                    '<%= hobbies.get(i).replace("'", "\\'") %>'<%= i < hobbies.size() - 1 ? "," : "" %>
                <% } %>
            ];

            // Re-populate the second dropdown depending on selection
            filterTypeSelect.addEventListener('change', function() {
                filterValueSelect.innerHTML = '<option value="">Choose...</option>';
                
                if (this.value === 'programme') {
                    programmes.forEach(function(prog) {
                        const option = document.createElement('option');
                        option.value = prog;
                        option.textContent = prog;
                        filterValueSelect.appendChild(option);
                    });
                } else if (this.value === 'hobby') {
                    hobbies.forEach(function(hb) {
                        const option = document.createElement('option');
                        option.value = hb;
                        option.textContent = hb;
                        filterValueSelect.appendChild(option);
                    });
                }
            });
        });
    </script>

</body>
</html>
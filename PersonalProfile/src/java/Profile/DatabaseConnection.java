package Profile;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseConnection {

    private static final String DB_URL = "jdbc:derby://localhost:1527/StudentProfilesDB";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "123";
    private static final String DB_DRIVER = "org.apache.derby.jdbc.ClientDriver";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DB_DRIVER);
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("SET SCHEMA APP");
        }
        return conn;
    }

    public static boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, profile.getStudentID());
            pstmt.setString(2, profile.getName());
            pstmt.setString(3, profile.getProgramme());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntroduction());
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error inserting profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static List<ProfileBean> getAllProfiles() {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM Profile";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                ProfileBean profile = new ProfileBean(
                    rs.getString("studentID"),
                    rs.getString("name"),
                    rs.getString("programme"),
                    rs.getString("email"),
                    rs.getString("hobbies"),
                    rs.getString("introduction")
                );
                profiles.add(profile);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error retrieving profiles: " + e.getMessage());
            e.printStackTrace();
        }
        return profiles;
    }

    public static ProfileBean searchByStudentID(String studentID) {
        String sql = "SELECT * FROM Profile WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new ProfileBean(
                        rs.getString("studentID"),
                        rs.getString("name"),
                        rs.getString("programme"),
                        rs.getString("email"),
                        rs.getString("hobbies"),
                        rs.getString("introduction")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error searching by Student ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public static List<ProfileBean> searchByName(String name) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM Profile WHERE name LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + name + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProfileBean profile = new ProfileBean(
                        rs.getString("studentID"),
                        rs.getString("name"),
                        rs.getString("programme"),
                        rs.getString("email"),
                        rs.getString("hobbies"),
                        rs.getString("introduction")
                    );
                    profiles.add(profile);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error searching by Name: " + e.getMessage());
            e.printStackTrace();
        }
        return profiles;
    }

    public static List<ProfileBean> filterByProgramme(String programme) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM Profile WHERE programme = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, programme);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProfileBean profile = new ProfileBean(
                        rs.getString("studentID"),
                        rs.getString("name"),
                        rs.getString("programme"),
                        rs.getString("email"),
                        rs.getString("hobbies"),
                        rs.getString("introduction")
                    );
                    profiles.add(profile);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error filtering by Programme: " + e.getMessage());
            e.printStackTrace();
        }
        return profiles;
    }

    public static List<ProfileBean> filterByHobby(String hobby) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM Profile WHERE hobbies LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + hobby + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProfileBean profile = new ProfileBean(
                        rs.getString("studentID"),
                        rs.getString("name"),
                        rs.getString("programme"),
                        rs.getString("email"),
                        rs.getString("hobbies"),
                        rs.getString("introduction")
                    );
                    profiles.add(profile);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error filtering by Hobby: " + e.getMessage());
            e.printStackTrace();
        }
        return profiles;
    }

    public static boolean deleteProfile(String studentID) {
        String sql = "DELETE FROM Profile WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentID);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error deleting profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateProfile(ProfileBean profile) {
        String sql = "UPDATE Profile SET name = ?, programme = ?, email = ?, hobbies = ?, introduction = ? WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getProgramme());
            pstmt.setString(3, profile.getEmail());
            pstmt.setString(4, profile.getHobbies());
            pstmt.setString(5, profile.getIntroduction());
            pstmt.setString(6, profile.getStudentID());
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
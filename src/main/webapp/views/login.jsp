<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RelaXit | Exclusive Members Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
   
   <script src="https://accounts.google.com/gsi/client" async defer></script>
    <meta name="google-signin-client_id" content="1000171418756-7fohbjvk79c7rovji8b6gu7lks2csgi2.apps.googleusercontent.com">
   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
   <style>
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>
    
</head>
<body>
    <div class="luxury-auth-wrapper">
        <!-- Background Section -->
        <div class="luxury-background-section">
            <div class="background-overlay"></div>
            <div class="background-content">
                <img src="${pageContext.request.contextPath}/assets/img/relaxit-logo.png" alt="RelaXit Logo" class="background-logo">
                <div class="brand-message">
                    <h2>Experience Unparalleled Comfort</h2>
                    <p>Discover furniture crafted exclusively for the discerning few</p>
                </div>
            </div>
        </div>
        
        <!-- Form Section -->
       <!-- في الـ luxury-form-section بعد الـ form-navigation مثلاً -->
<div class="luxury-form-section">
    <div class="brand-header">
        <h1 class="brand-title">RelaXit</h1>
        <p class="brand-tagline">Exclusive furniture for distinguished living</p>
    </div>

  <% if (request.getAttribute("successMessage") != null) { %>
    <div style=" 
        background-color: #d4edda;
        color: #155724;
        padding: 15px;
        margin: 15px 0;
        border: 1px solid #c3e6cb;
        border-radius: 8px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 16px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: all 0.3s ease-in-out;
        animation: fadeIn 0.8s ease-in-out;
    ">
        ✅ <%= request.getAttribute("successMessage") %>
    </div>
<% } %>

    <div class="form-navigation">
        <button class="nav-btn active" id="loginNav">Sign In</button>
        <button class="nav-btn" id="registerNav">Register</button>
        <div class="nav-indicator"></div>
    </div>
    
            <!-- Login Form -->
            <form id="luxuryLoginForm" class="auth-form active" action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <input type="email" id="luxuryEmail" name="luxuryEmail" required>
                    <label for="luxuryEmail">Email Address</label>
                    <i class="fas fa-envelope input-icon"></i>
                </div>
                
                <div class="form-group password-group">
                    <input type="password" id="luxuryPassword" name="luxuryPassword" required>
                    <label for="luxuryPassword">Password</label>
                    <i class="fas fa-lock password-icon"></i>
                    <button type="button" class="password-toggle">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                
                <div class="remember-forgot-container">
                    <div class="remember-me">
                        <input type="checkbox" id="luxuryRemember" name="luxuryRemember">
                        <label for="luxuryRemember" style="font-size: large; padding-top:5px;">Remember me</label>
                    </div>
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                    <p style="color: red;"><%= request.getAttribute("error") %></p>
                <% } %>
                
                <button type="submit" class="luxury-btn">
                    <span>Access Your Collection</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
                
                <div class="social-auth">
                    <p class="divider-text">or continue with</p>
                    <div class="social-buttons">
                        <button type="button" class="social-btn"><i class="fab fa-apple"></i></button>
                    <div id="g_id_onload"
     data-client_id="1000171418756-7fohbjvk79c7rovji8b6gu7lks2csgi2.apps.googleusercontent.com"
     data-callback="handleCredentialResponse"
     data-auto_prompt="false">
</div>
<div class="g_id_signin"
     data-type="standard"
     data-size="large"
     data-theme="filled_black"
     data-text="sign_in_with"
     data-shape="rectangular"
     data-logo_alignment="left">
</div>
                        <button type="button" class="social-btn"><i class="fab fa-linkedin-in"></i></button>
                    </div>
                </div>
            </form>

            <!-- Registration Form -->
            <form id="luxuryRegisterForm" class="auth-form" action="${pageContext.request.contextPath}/register" method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-group avatar-upload-group">
                        <div class="avatar-upload-container">
                            <input type="file" id="luxuryProfileImage" name="luxuryProfileImage" accept="image/*" class="hidden-file-input">
                            <label for="luxuryProfileImage" class="avatar-upload-label">
                                <div class="avatar-preview">
                                    <img class="profile-preview" alt="Profile Preview">
                                    <div class="default-avatar"><i class="fas fa-user"></i></div>
                                </div>
                                <span class="avatar-upload-text">Choose Profile Photo</span>
                            </label>
                        </div>
                        <span id="profileImageError" class="validation-error"></span>
                    </div>

                    <div class="form-group">
                        <input type="text" id="luxuryFullName" name="luxuryFullName" required>
                        <label for="luxuryFullName">Full Name</label>
                        <i class="fas fa-user input-icon"></i>
                        <span id="fullNameError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group">
                        <input type="email" id="luxuryRegEmail" name="luxuryRegEmail" required>
                        <label for="luxuryRegEmail">Email Address</label>
                        <i class="fas fa-envelope input-icon"></i>
                        <span id="emailError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group password-group">
                        <input type="password" id="luxuryRegPassword" name="luxuryRegPassword" required>
                        <label for="luxuryRegPassword">Password</label>
                        <i class="fas fa-lock password-icon"></i>
                        <button type="button" class="password-toggle"><i class="fas fa-eye"></i></button>
                        <span id="passwordError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group">
                        <input type="date" id="luxuryBirthdate" name="luxuryBirthdate" required>
                        <label for="luxuryBirthdate" class="date-label">Date of Birth</label>
                        <span id="birthdateError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group">
                        <input type="text" id="luxuryProfession" name="luxuryProfession" required>
                        <label for="luxuryProfession">Profession</label>
                        <i class="fas fa-briefcase input-icon"></i>
                        <span id="professionError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group">
                        <input type="text" id="luxuryResidence" name="luxuryResidence" required>
                        <label for="luxuryResidence">Residence</label>
                        <i class="fas fa-home input-icon"></i>
                        <span id="residenceError" class="validation-error"></span>
                    </div>
                    
                    <div class="form-group full-width interests-group">
                        <input type="text" id="luxuryInterests" name="luxuryInterests">
                        <label for="luxuryInterests">Design Preferences</label>
                        <i class="fas fa-heart input-icon"></i>
                        <span id="interestsError" class="validation-error"></span>
                    </div>
                </div>
                
                <button type="submit" class="luxury-btn" id="registerBtn" disabled>
                    <span>Become a Member</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
                
                <p class="form-footer">
                    Already have an account? <a href="#" class="text-link" id="switchToLoginLink">Sign in</a>
                </p>
            </form>

           
        </div>
    </div>
<script>
    window.contextPath = "${pageContext.request.contextPath}";
</script>
    <script src="${pageContext.request.contextPath}/assets/js/login.js"></script>
    <script src="https://accounts.google.com/gsi/client" async defer></script>
</body>
</html>
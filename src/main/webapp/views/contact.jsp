<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | RelaXit - Where comfort meets spinal health</title>
	
	<link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">
	<link href="<c:url value='/assets/css/aos.css'/>" rel="stylesheet">

   
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>">

    <style>
		body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}
                        
        /* Contact Page*/
        .contact-section {
            padding: 80px 0 40px;
            background-color: #f8fafc;
            position: relative;
        }
        
        .contact-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 80%;
            height: 200%;
            background: radial-gradient(ellipse at center, rgba(3, 105, 161, 0.05) 0%, rgba(248, 250, 252, 0) 70%);
            transform: rotate(-20deg);
            pointer-events: none;
        }
        
        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 2;
        }
        
        .contact-header {
            text-align: center;
            margin-bottom: 60px;
        }
        
        .contact-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #0369a1;
        }
        
        .contact-header p {
            max-width: 700px;
            margin: 0 auto;
            color: #6a6a6a;
            font-size: 1.1rem;
        }
        
        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .contact-info {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .contact-info h2 {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: #0369a1;
            position: relative;
            padding-bottom: 10px;
        }
        
        .contact-info h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: #0369a1;
        }
        
        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
        }
        
        .info-item i {
            font-size: 1.2rem;
            color: #0369a1;
            margin-right: 15px;
            margin-top: 5px;
        }
        
        .info-content h3 {
            font-size: 1.1rem;
            margin-bottom: 5px;
            color: #1e293b;
        }
        
        .info-content p, .info-content a {
            color: #6a6a6a;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .info-content a:hover {
            color: #0369a1;
        }
        
        .cosocial-links {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .cosocial-links a {
			text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: #f1f5f9;
            color: #0369a1;
            border-radius: 50%;
            font-size: 1.2rem;
            transition: all 0.3s;
        }
        
        .cosocial-links a:hover {
            background-color: #0369a1;
            color: #ffffff;
        }
        
        .contact-form {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .contact-form h2 {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: #0369a1;
            position: relative;
            padding-bottom: 10px;
        }
        
        .contact-form h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: #0369a1;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #1e293b;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 1rem;
            transition: all 0.3s;
            background-color: #f8fafc;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #0369a1;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(3, 105, 161, 0.1);
        }
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        .btn-submit {
            display: inline-block;
            background-color: #0369a1;
            color: #ffffff;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn-submit:hover {
            background-color: #0284c7;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(3, 105, 161, 0.2);
        }
        
        .map-container {
            height: 350px;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 30px;
			margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .map-container iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
        
        .message-alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
        
        .success-message {
            background-color: #d1fae5;
            color: #065f46;
        }
        
        .error-message {
            background-color: #fee2e2;
            color: #b91c1c;
        }
        
        @media (max-width: 768px) {
            .contact-header h1 {
                font-size: 2rem;
            }
            
            .contact-header p {
                font-size: 1rem;
            }
            
            .contact-info, .contact-form {
                padding: 30px;
            }
        }
    </style>
</head>
<body>

	 <!-- Include the header with custom parameters -->
	 <jsp:include page="header.jsp">
		<jsp:param name="activePage" value="contact" />
		<jsp:param name="heroTitle" value="Contact Us" />
	 </jsp:include>

	
     <!-- Contact Section -->
	 <section class="contact-section">
        <div class="contact-container">
            <div class="contact-header">
                <h1>We're Here to Help</h1>
                <p>Have questions about our ergonomic products? Want to share feedback or suggestions? Our team is here to help you achieve better spinal health and comfort.</p>
            </div>
            
            <div id="successMessage" class="message-alert success-message">
                <i class="fas fa-check-circle"></i> Thank you for your message! We'll get back to you soon.
            </div>
            
            <div id="errorMessage" class="message-alert error-message">
                <i class="fas fa-exclamation-circle"></i> There was an error sending your message. Please try again.
            </div>
            
            <div class="contact-grid">
                <div class="contact-info">
                    <h2>Contact Information</h2>
                    
                    <div class="info-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="info-content">
                            <h3>Our Location</h3>
                            <p>123 Ergonomics Street, Comfort City, PO 45678</p>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <i class="fas fa-phone-alt"></i>
                        <div class="info-content">
                            <h3>Phone Number</h3>
                            <p><a href="tel:+1234567890">+1 (234) 567-890</a></p>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <i class="fas fa-envelope"></i>
                        <div class="info-content">
                            <h3>Email Address</h3>
                            <p><a href="mailto:info@relaxit.com">info@relaxit.com</a></p>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <i class="fas fa-clock"></i>
                        <div class="info-content">
                            <h3>Working Hours</h3>
                            <p>Monday - Friday: 9:00 AM - 6:00 PM</p>
                            <p>Saturday: 10:00 AM - 4:00 PM</p>
                        </div>
                    </div>
                    
                    <div class="cosocial-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                
                <div class="contact-form">
                    <h2>Send Us a Message</h2>
                    <form id="contactForm" action="ContactServlet" method="POST">
                        <div class="form-group">
                            <label for="name">Your Name</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <input type="text" id="subject" name="subject" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea id="message" name="message" class="form-control" required></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit">Send Message</button>
                    </form>
                </div>
            </div>
            
			<div class="map-container">
				<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3453.658170011031!2d31.0210984!3d30.0711173!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14585b979b7d1dd9%3A0x88f29d027c44f959!2z2YXYudmH2K8g2KfZhNiv2YjZhdin2YQg2KfZhNiv2YbYr9mJ2YUg2KfZhNiq2YTZitmB2Kk!5e0!3m2!1sen!2seg!4v1715700000000!5m2!1sen!2seg" 
						allowfullscreen="" 
						loading="lazy" 
						referrerpolicy="no-referrer-when-downgrade">
				</iframe>
			</div>
        </div>
    </section>
        

	<!-- Include the footer -->
	  <jsp:include page="footer.jsp" />

    <script>
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Hide any previous messages
            document.getElementById('successMessage').style.display = 'none';
            document.getElementById('errorMessage').style.display = 'none';
            
            // Get form data
            const formData = new FormData(this);
            
            // Send form data to server
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error('Network response was not ok');
                }
            })
            .then(data => {

                document.getElementById('successMessage').style.display = 'block';
                document.getElementById('contactForm').reset();
                document.getElementById('successMessage').scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('errorMessage').style.display = 'block';
                document.getElementById('errorMessage').scrollIntoView({ behavior: 'smooth' });
            });
        });
    </script>

  <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
  <script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
        <script src="<c:url value='/assets/js/custom.js'/>"></script>

        <script src="<c:url value='/assets/js/aos.js'/>"></script>
        <script src="<c:url value='/assets/js/animation.js'/>"></script>

</body>
</html>
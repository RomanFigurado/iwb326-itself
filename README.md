++++++++++++++++++++++++*Find Lawyer-Client Itself*+++++++++++++++++++++++++++++++++

*FRONT END*


Next.js Frontend for Lawyer-Client Platform

This repository contains the frontend code for a lawyer-client platform built with Next.js. The platform allows clients to find registered lawyers based on their expertise, fees, and availability, while providing lawyers with a way to gain visibility and manage their profiles.

Features

	•	Lawyer Registration: Lawyers can sign up, create profiles, and list their expertise, availability, and fees.
	•	Client Access: Clients can search for lawyers, view profiles, and book consultations.
	•	Responsive Design: The UI is built with Tailwind CSS for a modern, responsive experience across devices.
	•	Server-Side Rendering: Utilizes Next.js’s server-side rendering for faster page loads and SEO-friendly content.
	•	API Integration: Fetches data from a backend API built in Ballerina.

Tech Stack

	•	Next.js: React-based framework for building server-side rendered applications.
	•	TypeScript: Type safety for cleaner and maintainable code.
	•	Tailwind CSS: Utility-first CSS framework for building responsive designs quickly.
	•	Fetch API: Used for making requests to the Ballerina-based backend.
	•	Vercel: (Optional) Platform for deployment and hosting of Next.js applications.

Prerequisites

Before running the project, ensure you have the following installed on your machine:

	•	Node.js (version 14.x or above)
	•	npm or yarn (for package management)

Getting Started

1. Clone the repository

git clone https://github.com/yourusername/lawyer-client-platform-frontend.git
cd lawyer-client-platform-frontend

2. Install dependencies

If you’re using npm:

npm install

If you’re using yarn:

yarn install

3. Configure Environment Variables

Create a .env.local file in the root directory for environment variables. Add the following:

NEXT_PUBLIC_BACKEND_API_URL=http://localhost:8083/lawyerprofile

4. Run the development server

To start the local development server:

npm run dev

or

yarn dev

Now open http://localhost:3000 to view the app in your browser.

Project Structure

.
├── components       # Reusable components (e.g., LawyerCard, Layout)
├── pages            # Next.js pages (e.g., index.tsx, signup.tsx)
├── public           # Static assets (e.g., images, icons)
├── styles           # Global CSS and Tailwind configuration
├── types            # TypeScript type definitions
├── .env.local       # Environment variables
└── README.md        # Project documentation

Key Folders:

	•	components: Contains all the reusable UI components like LawyerCard, Navbar, etc.
	•	pages: Contains all page components. These map directly to routes in the application (e.g., /signup, /profiles).
	•	styles: Contains global styles and Tailwind CSS configuration.
	•	types: Contains TypeScript interfaces and types used throughout the app.

Scripts

	•	npm run dev or yarn dev: Start the development server.
	•	npm run build or yarn build: Build the project for production.
	•	npm run start or yarn start: Start the production server.
	•	npm run lint or yarn lint: Run ESLint to lint the code.

Deployment

The project can be easily deployed to platforms like Vercel or Netlify. Follow these steps for Vercel:

	1.	Commit your code to GitHub.
	2.	Go to Vercel, sign in with GitHub, and import your repository.
	3.	Configure the environment variables on Vercel (same as in .env.local).
	4.	Deploy your app.

Learn More

To learn more about the tools used in this project:

	•	Next.js Documentation
	•	Tailwind CSS Documentation
	•	TypeScript Documentation

Feel free to customize this README file as per your specific project requirements.



---------------------------------------------*Front end*------------------------------------------------------------------


*BACKEND*

Features
User authentication (sign up, sign in, log out)
Management of client and lawyer profiles
Appointment scheduling between clients and lawyers
Payment processing for services rendered
Review system for clients to evaluate lawyers

Technologies Used
Ballerina
MySQL
HTTP/RESTful APIs

Installation
Clone the repository:
Copy code
git clone https://github.com/yourusername/legal-management-system-backend.git
cd legal-management-system-backend

Install the required dependencies:
Make sure you have Ballerina installed. If not, follow the installation instructions from the Ballerina website.
Configure your database settings in the .bal files as needed.

Usage
To run the program, use the following command:
Copy code
ballerina run 


POSTMAN :-
For example (Authentication Service)
API Endpoints
Authentication Service
--Sign Up
Endpoint: POST /auth/signup
Request Body:
json
Copy code
{
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@example.com",
    "password": "securepassword",
    "role": "client"
}

Response: Returns user ID on successful registration.

--Sign In
Endpoint: POST /auth/signin
Query Parameters:
email: User's email
password: User's password
Response: Returns a success message on successful login.

--Log Out
Endpoint: POST /auth/logout
Query Parameters:
email: User's email
Response: Returns a success message on logout.


---------------------------------------------*Back end*------------------------------------------------------------------

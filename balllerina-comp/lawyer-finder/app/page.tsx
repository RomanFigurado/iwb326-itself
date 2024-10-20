import React from 'react';

const HomePage = () => {
  return (
    <div className="container mx-auto p-6 max-w-1200px relative">
      {/* Welcome Section */}
      <section className="text-center mb-12">
        <h1 className="text-4xl font-bold mb-4">Welcome to Lawyer Finder</h1>
        <p className="text-xl text-gray-700">Connecting You with Trusted Legal Professionals</p>
      </section>

      {/* For Clients Section */}
      <section className="mb-12">
        <h2 className="text-3xl font-semibold mb-6 text-center">For Clients</h2>
        <div className="grid md:grid-cols-2 gap-8">
          <div className="bg-white shadow-md rounded-lg p-6">
            <h3 className="text-2xl font-semibold mb-3">Find the Right Lawyer</h3>
            <p className="text-gray-700 mb-4">
              Finding the right legal support has never been easier. Browse through our extensive list of qualified
              lawyers, each specializing in various areas of law.
            </p>
            <ul className="list-disc list-inside text-gray-600">
              <li>Browse Verified Lawyer Profiles</li>
              <li>Compare Expertise and Fees</li>
              <li>Book Consultations Seamlessly</li>
            </ul>
          </div>
          <div className="bg-white shadow-md rounded-lg p-6">
            <img src="/images/client.svg" alt="Clients" className="w-full h-48 object-contain rounded-lg" />
          </div>
        </div>
      </section>

      {/* For Lawyers Section */}
      <section className="mb-12">
        <h2 className="text-3xl font-semibold mb-6 text-center">For Lawyers</h2>
        <div className="grid md:grid-cols-2 gap-8">
          <div className="bg-white shadow-md rounded-lg p-6">
            <h3 className="text-2xl font-semibold mb-3">Grow Your Practice</h3>
            <p className="text-gray-700 mb-4">
              Get your profile in front of clients actively looking for legal services. Share your expertise,
              availability, and fees to connect with potential clients.
            </p>
            <ul className="list-disc list-inside text-gray-600">
              <li>Gain Access to Potential Clients</li>
              <li>Showcase Your Legal Expertise</li>
              <li>Manage Availability and Consultations</li>
            </ul>
          </div>
          <div className="bg-white shadow-md rounded-lg p-6">
            <img src="/images/login.svg" alt="Lawyers" className="w-full h-48 object-contain rounded-lg" />
          </div>
        </div>
      </section>

      {/* How It Works Section */}
      <section className="text-center mb-12">
        <h2 className="text-3xl font-semibold mb-6">How It Works</h2>
        <div className="grid md:grid-cols-3 gap-8">
          <div className="bg-white shadow-md rounded-lg p-6">
            <h3 className="text-2xl font-semibold mb-3">Sign Up</h3>
            <p className="text-gray-700">
              Whether you're a client or a lawyer, registration is quick and easy.
            </p>
          </div>
          <div className="bg-white shadow-md rounded-lg p-6">
            <h3 className="text-2xl font-semibold mb-3">Find the Right Match</h3>
            <p className="text-gray-700">
              Clients can search through profiles to find a lawyer who fits their needs.
            </p>
          </div>
          <div className="bg-white shadow-md rounded-lg p-6">
            <h3 className="text-2xl font-semibold mb-3">Get Connected</h3>
            <p className="text-gray-700">
              Reach out directly to lawyers for consultations and services.
            </p>
          </div>
        </div>
      </section>

      {/* Call to Action Section */}
      <section className="text-center">
        <a
          href="/register"
          className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition duration-300 ease-in-out mr-4"
        >
          Sign Up Now
        </a>
        <a
          href="/browse-lawyers"
          className="bg-gray-600 text-white px-6 py-3 rounded-lg hover:bg-gray-700 transition duration-300 ease-in-out"
        >
          Explore Lawyer Profiles
        </a>
      </section>
    </div>
  );
};

export default HomePage;

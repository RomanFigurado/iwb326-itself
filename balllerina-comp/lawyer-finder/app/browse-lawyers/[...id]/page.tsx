'use client'
import { CustomButton } from '@/components';
import { useParams } from 'next/navigation'
import { useEffect, useState } from 'react';

const page = () => {
    const id = useParams().id;
    const [lawyer, setLawyer] = useState({
        "user_id": null,
        "first_name": '',
        "last_name": '',
        "email": '',
        "role": '',
        "expertise": '',
        "fees": null,
        "availability": false
    });
    const [reviews, setReviews] = useState([{ "client_id": null, "comments": '', "id": null, "lawyer_id": null, "rating": 1 }]);
    const fetLawyerData = async () => {
        const response = await fetch(`http://localhost:8083/lawyerprofile/${id}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        const lawyer = await response.json();
        setLawyer(lawyer);
    }
    const fetLawyerReviews = async () => {
        const response = await fetch(`http://localhost:8084/reviewsclient/${id}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });
        const reviews = await response.json();
        setReviews(reviews);
    }
    let oRate = 0;
    useEffect(() => {
        fetLawyerData();
        fetLawyerReviews();
    }, [])
    reviews.forEach(review => {
        oRate += review?.rating
    })
    oRate = parseFloat((oRate / (reviews.length)).toFixed(1));
    return (
        <main className='max-w-[1200px] relative mx-auto px-10 py-20'>
            <h1 className='font-bold text-3xl text-red-950 mb-10'>Meet {lawyer.first_name} {lawyer.last_name} Industry Expert Lawyer in {lawyer.expertise}...</h1>
            <div className="relative flex items-center justify-between mb-10">
                <div className="info">
                    <p className='text-blue-800 font-bold text-xl'>Availability: <span className='text-black'>{lawyer.availability ? "Available" : "Currently Unavailable"}</span></p>
                    <p className='text-blue-800 font-bold text-xl'>Hourly Rate: <span className='text-black'>Rs {lawyer.fees} /Hr</span></p>
                    <p className='text-blue-800 font-bold text-xl'>Overall Rating: <span className='text-black'>{oRate} / 5</span></p>
                </div>
                {lawyer.availability && (
                    <div>
                        <h2 className='font-semibold mb-2'>Want to Talk?</h2>
                        <CustomButton title='Schedule An Appointment' containerStyles='hover:bg-red-950 hover:text-white transition' />
                    </div>
                )}

            </div>
            {reviews && (
                <div>
                    <h2 className='font-bold text-2xl text-red-950 mb-10'>Reviews by {lawyer.first_name}'s Clients</h2>
                    {reviews && (
                        reviews.map(review => (
                            <div key={review.id} className='px-2 py-4 border-b-2 border-red-950'>
                                <div className='flex justify-between mb-1'>
                                    <p className='font-bold text-xl'>"{review.comments}"</p>
                                    <p className='font-bold text-2xl text-orange-600'>{review.rating} / 5.0</p>
                                </div>
                            </div>
                        ))
                    )}
                </div>
            )}
        </main>
    )
}

export default page
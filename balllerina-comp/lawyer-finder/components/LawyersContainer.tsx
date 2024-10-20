import { Key } from "react";
import LawyerCard from "./LawyerCard"
import { LawyerProps } from "@/types";

const LawyersContainer = async () => {
    const response = await fetch('http://localhost:8083/lawyerprofile', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    });
    const lawyers = await response.json();
    return (
        <div className="relative grid grid-wrapper gap-5">
            {
                lawyers.map((lawyer: LawyerProps) => (
                    <LawyerCard key={lawyer.user_id} user_id={lawyer.user_id} first_name={lawyer.first_name} last_name={lawyer.last_name} expertise={lawyer.expertise} fees={lawyer.fees} />
                ))
            }
        </div>
    )
}

export default LawyersContainer
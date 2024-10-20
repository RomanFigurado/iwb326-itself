'use client'

import { useRouter } from "next/navigation";
import CustomButton from "./CustomButton"
import { LawyerProps } from "@/types";

const LawyerCard = ({ user_id, first_name, last_name, expertise, fees }: LawyerProps) => {
    const id = 1;
    const route = useRouter();
    const navigateToLawyerDetails = (id: number) => {
        route.push(`/browse-lawyers/${user_id}`)
    }
    return (
        <div className="Relative px-2 py-5 border-2 border-red-950 rounded-lg min-w-[200px] text-center">
            <h3 className="font-bold text-2xl">{first_name} {last_name}</h3>
            <p>Industry Expert in {expertise}</p>
            <CustomButton title="View Lawyer" containerStyles="rounded-lg text-white bg-red-950 mt-5 font-bold" handleClick={() => navigateToLawyerDetails(id)} />
        </div>
    )
}

export default LawyerCard
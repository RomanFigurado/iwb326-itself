"use client"
import { useParams } from "next/navigation";

const page = () => {
    const id = useParams().id;
    return (
        <main>
            <div>Lawyer Detail Edit Page</div>
            <p>{id}</p>
        </main>
    )
}

export default page
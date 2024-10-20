"use client"
import Link from "next/link"
import CustomButton from "./CustomButton"
import { useState } from "react"
import { useRouter } from "next/navigation"

const Header = () => {
    const [isLogged, setIsLogged] = useState(false);
    const router = useRouter();
    const handleClick = () => {
        if (!isLogged) {
            router.push('/login');
        }
    }
    return (
        <nav className="flex relative justify-between w-full p-3 m-auto max-w-[1200px]">
            <Link href="/">
                <h1 className="relative text-blue-950 font-extrabold text-[30px]">Lawyer Finder</h1>
            </Link>
            <div className="links flex gap-4 ">
                <Link href="/" className="active relative h-auto flex flex-col justify-center">Home</Link>
                <Link href="/browse-lawyers" className="active relative h-auto flex flex-col justify-center">Browse Lawyers</Link>
                <CustomButton
                    title={!isLogged ? "Login" : "Logout"}
                    handleClick={handleClick}
                />
            </div>
        </nav>
    )
}

export default Header
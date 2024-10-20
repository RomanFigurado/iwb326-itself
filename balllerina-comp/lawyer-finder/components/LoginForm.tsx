"use client"
import { ChangeEvent, FormEvent, useState } from "react";
import CustomButton from "./CustomButton";
import Link from "next/link";
import { useRouter } from "next/navigation";

const LoginForm = () => {
    const [user, setUser] = useState({ email: '', password: '' });
    const router = useRouter();
    const [error, setError] = useState(null);
    const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
        setUser({ ...user, [e.target.name]: e.target.value })
    }
    const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        console.log(user, "Userrrrrrrr");
        const response = await fetch('http://localhost:8081/auth/signin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                "email": user.email,
                "password": user.password
            }),
        });
        const data = await response.json();
        if (response.ok) {
            if (data.role === "client") {
                router.push('/browse-lawyers')
            } else {
                router.push(`/edit-lawyer-details/${data.user_id}`)
            }
        } else {
            setError(data.message || 'Signup failed');
        }
    }
    return (
        <form onSubmit={handleSubmit} className="relative flex flex-col gap-10 border-l-2 border-b-red-900 px-10 py-5">
            <h2 className="text-4xl font-bold text-red-950 underline">Login</h2>
            <label>
                <p>Email</p>
                <input type="email" name="email" value={user.email} placeholder="enter your email" onChange={handleChange} />
            </label>
            <label>
                <p>Password</p>
                <input type="password" name="password" value={user.password} placeholder="enter your password" onChange={handleChange} />
            </label>

            <CustomButton title="Submit" type="submit" containerStyles="text-white font-bold bg-red-900" />
            <p className="font-semibold">Don't have an Account? <Link href="/register" className="underline">Register Here</Link></p>
        </form>
    )
}

export default LoginForm;
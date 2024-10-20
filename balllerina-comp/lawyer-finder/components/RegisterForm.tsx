"use client"
import { ChangeEvent, FormEvent, useState } from "react";
import CustomButton from "./CustomButton";
import Link from "next/link";
import { useRouter } from "next/navigation";

const RegisterForm = () => {
    const [user, setUser] = useState({ firstName: '', lastName: '', email: '', password: '', role: 'client' });
    const [error, setError] = useState(null);
    const router = useRouter();
    const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
        setUser({ ...user, [e.target.name]: e.target.value })
    }
    const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        console.log(user, "Userrrrrrrr");
        const response = await fetch('http://localhost:8081/auth/signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                "first_name": user.firstName,
                "last_name": user.lastName,
                "email": user.email,
                "password": user.password,
                "role": user.role
            }),
        });
        const data = await response.json();
        console.log(data)
        if (response.ok) {
            router.push('/login')
        } else {
            setError(data.message || 'Signup failed');
        }


    }
    return (
        <form onSubmit={handleSubmit} className="relative flex flex-col gap-10 border-r-2 border-b-red-900 px-10 py-5">
            <h2 className="text-4xl font-bold text-red-950 underline">Register</h2>
            <label>
                <p>First Name</p>
                <input type="text" required name="firstName" value={user.firstName} placeholder="enter your first name" onChange={handleChange} />
            </label>
            <label>
                <p>Last Name</p>
                <input type="text" required name="lastName" value={user.lastName} placeholder="enter your last name" onChange={handleChange} />
            </label>
            <label>
                <p>Email</p>
                <input type="email" required name="email" value={user.email} placeholder="enter your email" onChange={handleChange} />
            </label>
            <label>
                <p>Password</p>
                <input type="password" required name="password" value={user.password} placeholder="enter your password" onChange={handleChange} />
            </label>
            <div>
                <p className="label">Role</p>
                <div className="flex relative gap-10">
                    <label className="flex relative gap-2">
                        <input type="radio" name="role" value="client" onChange={handleChange} />
                        <span>Client</span>
                    </label>
                    <label className="flex relative gap-2">
                        <input type="radio" name="role" value="lawyer" onChange={handleChange} />
                        <span>Lawyer</span>
                    </label>
                </div>
            </div>
            {error && <p>{error}</p>}
            <CustomButton title="Submit" type="submit" containerStyles="text-white font-bold bg-red-900" />
            <p className="font-semibold">Already have an Account? <Link href="/login" className="underline">Login Here</Link></p>
        </form>
    )
}

export default RegisterForm;
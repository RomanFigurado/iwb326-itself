"use client"
import { CustomButtonProps } from "@/types"

const CustomButton = ({ title, type, handleClick, containerStyles }: CustomButtonProps) => {
    return (
        <button
            className={`relative border border-blue-950 p-10 pt-2 pb-2 rounded-full ${containerStyles}`}
            type={type || "button"}
            onClick={handleClick}
        >
            {title}
        </button>
    )
}

export default CustomButton
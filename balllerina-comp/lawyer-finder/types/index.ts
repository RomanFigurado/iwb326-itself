import { MouseEventHandler } from "react";

export interface CustomButtonProps {
    title: string;
    type?: "submit" | "button";
    handleClick?: MouseEventHandler<HTMLButtonElement>;
    containerStyles?: string;
}

export interface LawyerProps {
    user_id: number;
    first_name: string;
    last_name: string;
    email?: string;
    role?: string;
    expertise?: string;
    fees?: number;
    availability?: boolean;
}
import LoginForm from '@/components/LoginForm'
import Image from 'next/image'

const page = () => {
    return (
        <div className='relative mx-auto max-w-[1200px] flex justify-center items-center gap-10 min-h-[700px]'>
            <div className='relative object-contain'>
                <Image src="/images/login.svg" alt='Login Image' width={300} height={300} />
            </div>
            <div><LoginForm /></div>
        </div>
    )
}

export default page
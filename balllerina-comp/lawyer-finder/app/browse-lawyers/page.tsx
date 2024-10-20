import LawyersContainer from "@/components/LawyersContainer"

const page = () => {
    return (
        <main className="relative mx-auto max-w-[1200px] py-20 px-10">
            <h1 className="text-center text-red-950 font-bold text-4xl mb-20">Looking for a Lawyer?</h1>
            <LawyersContainer />
        </main>
    )
}

export default page
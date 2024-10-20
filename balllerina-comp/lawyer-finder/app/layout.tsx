import type { Metadata } from "next";
import "@/public/css/styles.css";
import { Footer, Header } from "@/components";

export const metadata: Metadata = {
  title: "Lawyer Finder",
  description: "Get Connected with Your nearby Lawyers",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
      >
        <Header />
        {children}
        <Footer />
      </body>
    </html>
  );
}

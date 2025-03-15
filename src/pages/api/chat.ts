/// <reference types="astro/client" />
import type { APIRoute } from 'astro';
import { GoogleGenerativeAI } from '@google/generative-ai';

interface Message {
  role: string;
  content: string;
}

const PERSONAL_CONTEXT = `
I am Akhil Raghav. Here's my background:
- Experienced iOS Developer in the past
- Currently focused on Competitive Programming
- Backend Developer with strong system design skills
- Love solving algorithmic challenges
- Tech stack includes various backend technologies

Please keep this context in mind while responding. Always speak as if you are representing me.
`;

const genAI = new GoogleGenerativeAI(import.meta.env.GOOGLE_API_KEY);

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash" });

    const lastMessage = body.messages[body.messages.length - 1];
    // Combine personal context with user's message
    const prompt = `${PERSONAL_CONTEXT}\n\nUser's message: ${lastMessage.content}\n\nResponse:`;
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();

    return new Response(
      JSON.stringify({
        message: text,
      }),
      {
        status: 200,
        headers: {
          'Content-Type': 'application/json',
        },
      }
    );
  } catch (error) {
    console.error('Gemini API Error:', error);
    return new Response(
      JSON.stringify({
        error: 'Failed to generate response',
      }),
      {
        status: 500,
        headers: {
          'Content-Type': 'application/json',
        },
      }
    );
  }
};

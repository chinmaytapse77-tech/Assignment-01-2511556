# Vector Databases — Part 4

## Vector DB Use Case

A traditional keyword-based search system would not be sufficient for a law firm wanting to query 500-page contracts in plain English. Keyword search works by matching exact words or phrases — if a lawyer types "termination clauses", the system would only return paragraphs that contain those exact words. However, legal contracts are written in formal, varied language. A termination clause might be titled "Cessation of Agreement", "Exit Provisions", or "Conditions for Dissolution" — none of which contain the word "termination". A keyword search would miss all of these, leaving the lawyer with incomplete or no results.

This is precisely the problem that vector databases solve. Instead of matching words, a vector database matches meaning. When the lawyer types "What are the termination clauses?", the query is converted into a numerical vector using an embedding model. The system then searches for contract paragraphs whose embeddings are closest to the query vector in terms of cosine similarity — regardless of the exact words used. A paragraph about "exit provisions" would score highly because it carries the same semantic meaning as "termination", even though the words are different.

The practical implementation for this law firm would involve splitting each contract into smaller chunks (paragraphs or sections), generating an embedding for each chunk using a model like `all-MiniLM-L6-v2`, and storing those embeddings in a vector database such as Pinecone, Weaviate, or ChromaDB. When a lawyer submits a plain English query, the system embeds the query and retrieves the top matching chunks, which are then displayed as results or passed to a language model to generate a structured answer.

In summary, a keyword database would only find exact matches and would fail on the varied language of legal documents. A vector database understands meaning, making it the essential component for building a reliable, natural language contract search system for the law firm.

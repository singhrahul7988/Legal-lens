# Legal Lens - Project Context

> **Note:** This file is used to maintain the context of the project, including product requirements, development status, and architectural decisions. It should be updated as the project evolves.

## 1. Product Overview
**Product Name:** Legal Lens  
**Version:** 1.0 (Initial Concept)  
**Date:** January 27, 2026  
**Product Owner:** Rahul (Ludhiana, Punjab, India)

**Overview:**  
Legal Lens is a mobile-first AI-powered app designed for everyday Indians to handle routine personal legal and financial documents without needing a lawyer. It combines document analysis (upload & understand), red-flag detection, question-answering, and document creation (template-based generation) into a seamless full-cycle tool.

**Focus Areas:**  
High-pain, high-frequency scenarios like rentals, medical bills, employment offers, loans, insurance, and consumer disputes.

**Legal Context:**  
Relevant laws include the Model Tenancy Act, Consumer Protection Act, RERA, and IRDAI guidelines.

## 2. Vision & Mission
**Vision:**  
To democratize access to fair and clear personal legal & financial documents for millions of non-experts in India, preventing common exploitation and saving time, money, and stress.

**Mission:**  
Provide an intuitive, AI-driven companion that lets users:
- Upload and instantly understand any document.
- Create fair, balanced drafts from scratch.
- Spot issues, negotiate better terms, and export/share seamlessly.

**Core Promise:**  
Legal Lens is a “first line of defense” tool—not a replacement for lawyers.  
*Disclaimer:* “This is AI-generated general information and templates. It is not legal advice. Consult a qualified professional for binding matters.”

## 3. Value Proposition
- **Save Money:** Detect unfair charges (e.g., double-billed hospital tests, excessive rent deposits).
- **Save Time:** Condense long documents into bullet points; generate drafts in minutes.
- **Reduce Risk:** Flag red flags, missing protections, or deviations from norms.
- **Gain Confidence:** Plain-English explanations and ready-to-use negotiation messages.
- **Act Proactively:** Create balanced documents instead of accepting exploitative ones.
- **Share Easily:** Export PDFs/Word files for quick sharing via WhatsApp, Telegram, etc.

**India-Specific Edge:**  
Built-in alerts for common issues under Indian laws with support for English and major regional languages (Hindi, Punjabi, etc.).

## 4. Target Audience & Personas
**Primary Users:**
- Young professionals/families renting apartments.
- Salaried employees (job offers, resignations).
- Patients/families (medical bills, insurance).
- Borrowers (loans, credit cards).
- Consumers (utility disputes, e-commerce).

**Key Personas:**
1. **Rahul (28, Ludhiana):** IT professional renting a flat; wants fair lease terms.
2. **Priya (35, homemaker):** Handles family medical bills; needs to spot overcharges.
3. **Aman (24, fresher):** Reviewing first job offer; concerned about non-compete clauses.
4. **General Urban Indian:** 25–45 years old, middle-income, smartphone user, limited legal knowledge.

## 5. Key Features & Requirements

### 5.1 Document Analysis (Core Upload & Understand)
- **Upload:** PDF, images, Word.
- **Instant Summary:** 5–10 bullet points (user-selected focus).
- **Red-Flag Scanner:** Severity-rated alerts (Mild/Moderate/High).
- **Recalculation & Fairness Checker:** Auto-recompute totals, flag duplicates.
- **Smart Q&A Chat:** Natural-language questions about the document.
- **Timeline & Deadline Extractor:** Pull dates into a calendar/list.
- **Clause Comparison:** Side-by-side diff of two documents.
- **Negotiation Cheat Sheet:** Generate negotiation messages.
- **Language Support:** English + Hindi/Punjabi/etc.
- **India Law Alerts:** Flags for Model Tenancy Act, RERA, etc.

### 5.2 Document Creation / Template Generator
- **Template Library:**
  - Residential Rental/Lease Agreement
  - Notice to Vacate / Tenant Notice
  - Rent Increase Notice
  - Medical Bill / Hospital Complaint Letter
  - Consumer Refund/Complaint Letter
  - Resignation / Leave Application Letter
  - Security Deposit Refund Demand
  - Loan Prepayment Request
  - Insurance Claim Intimation
- **Guided Input:** Simple forms defaulting to reasonable/fair terms.
- **AI Generation:** Plain-English drafts with balanced clauses.
- **Post-Generation Analysis:** Self-check red-flag scanner.
- **Editing:** In-app editor with track changes.
- **Export & Sharing:**
  - **Formats:** PDF (with placeholder e-sign), editable Word/Docx.
  - **Direct Share:** WhatsApp, Telegram, Email, Google Drive, local storage.
  - **Watermark:** Subtle disclaimer on all generated docs.

### 5.3 Additional Supporting Features
- **Mobile-First UX:** Simple onboarding, dark mode, offline upload queue.
- **History & Library:** Saved uploads, created docs, past analyses.
- **Disclaimers Everywhere:** Prominent banners, footers, and pop-ups.
- **Feedback Loop:** In-app rating after each use to improve templates/alerts.

## 6. Key User Flows (Full-Cycle Examples)

**Flow 1: Rental Agreement Creation & Negotiation**
1. Select “Rental Agreement” template.
2. Fill form (tenant/landlord details, rent ₹15,000, 11 months, 2-month deposit).
3. Generate draft → Analyze: “Deposit fair, notice 1 month both sides—good.”
4. Edit if needed → Export PDF → Share via WhatsApp to landlord.

**Flow 2: Hospital Bill Dispute**
1. Upload bill image/PDF.
2. Summary + flags: “Duplicate ₹8,000 medicine charge; total over by ₹12,400.”
3. Generate complaint letter template (pre-filled with flagged issues).
4. Customize → Export → Share to hospital via email/WhatsApp.

**Flow 3: Job Offer Review & Counter**
1. Upload offer letter.
2. Flags: “3-month notice high for fresher role.”
3. Generate counter-offer email: “Request 1-month notice per industry norm.”
4. Export and send.

## 7. Non-Functional Requirements
- **Platform:** Mobile app (iOS + Android); web version optional later.
- **AI Backend:** LLM-powered (e.g., Grok or similar) for summarization, generation, analysis.
- **Security:** Encrypted uploads, no storage of sensitive docs without consent.
- **Performance:** < 60 seconds for analysis/generation on average document.
- **Scalability:** Handle regional language processing.
- **Compliance:** Clear disclaimers; no claim of providing legal advice.

## 8. Monetization & Business Model (Initial Thoughts)
**Freemium:**
- **Free:** Basic analysis (limited uploads/month), 2–3 templates, basic exports.
- **Premium:** Unlimited uploads/creations, advanced templates, priority processing, multi-language priority.
- **Future:** In-app legal consultation referrals (affiliate), partnerships with consumer forums.

## 9. Risks & Mitigations
- **Risk:** Perceived as giving legal advice.
  - *Mitigation:* Heavy, repeated disclaimers; no guarantees.
- **Risk:** Inaccurate AI flags/generations.
  - *Mitigation:* Start with conservative alerts; user feedback loop; human-reviewed template base.
- **Risk:** Language/Regional Law Variations.
  - *Mitigation:* India-first focus; expand templates gradually.
- **Risk:** Data Privacy.
  - *Mitigation:* Minimal storage; delete after use option.

## 10. Technical Stack
- **Frontend:** Flutter (Mobile-first, Cross-platform)
- **Backend:** Serverpod (Dart)
- **Database:** PostgreSQL (implied by Serverpod)
- **AI Integration:** Google Gemini (Flash Model) via `google_generative_ai`
- **Caching:** Redis (Serverpod built-in) for Chat History & Document Persistence
- **Auth:** Serverpod Auth (Email + Google) with `UuidValue` User IDs

## 11. Development Log
- **[2026-01-27]** Project Initialized. PRD Context added (Part 1 & 2).
- **[2026-01-30]** Backend Integration Complete.
  - Implemented `AiEndpoint`, `DocumentEndpoint`, `UserImageEndpoint`.
  - Integrated Gemini AI for multimodal analysis (Text + Images).
  - Added Client-side DOCX parsing.
  - Resolved Authentication & Type Safety issues (`UuidValue`).
  - Fixed Web/Mobile compatibility for Image Cropping.

## 12. MVP State Snapshot (Formatting & Context)
*Snapshot Date: 2026-01-28*

This section captures the visual and functional state of the application near the MVP milestone to ensure consistency if reverted or extended.

### 12.1 Visual Identity & Theme
- **Design System:** Material 3 (Flutter).
- **Font Family:** `Segoe UI`.
- **Color Palette:**
  - **Primary Blue:** `#1E207A` (Brand identity, headers, buttons).
  - **Secondary Yellow:** `#F7B500` (Accents, highlights).
  - **Background:** `#F6F7FB` (Light grey/white for clean look).
  - **Text:** Dark (`#101828`) for headings, Grey (`#667085`) for body/subtitles.
  - **Status Colors:** Success (`#22C55E`), Error (`#E5484D`), Warning (`#F59E0B`).

### 12.2 Responsiveness & Layout Structure
- **Global Layout:**
  - **Safe Area:** Wrapped globally in `Scaffold` body.
  - **Padding:** Standard screen padding is `20.0` (Dashboard).
  - **Navigation:** Bottom Navigation Bar with 5 items; Center Docked Floating Action Button (Size: 64x64).

### 12.3 Screen-Specific Context
#### A. Dashboard Screen
- **Structure:** `SingleChildScrollView` -> `Column`.
- **Key Sections:** Top Bar (Greeting), Header (Stats), Action Cards (Grid/Row), Recent Activity (List).
- **Navigation Logic:** Custom `_onItemTapped` handles tab switching; FAB pushes `CreateDraftScreen`.

#### B. Ask AI Screen (Dynamic)
- **State Management:** `StatefulWidget` handling message list `_messages`.
- **Initial State:** Auto-greeting acknowledging "12 previously analyzed files".
- **Interactivity:**
  - **File Attachment:** Uses `FilePicker` (PDF, JPG, PNG, DOC).
  - **Typing Indicator:** Boolean `_isTyping` triggers UI feedback.
  - **Mock Logic:** Keyword detection ("rental", "conflict") triggers specific pre-written responses.
  - **Suggestions:** Clickable chips below AI messages.

#### C. Analysis Screen
- **Flow:** Upload -> Mock Loading (2s) -> Result View.
- **Components:** Custom `ScoreGauge` for risk visualization.

#### D. Profile Screen
- **Layout:** Vertical List (`Column` in `ScrollSelectView`).
- **Sections:** Account (Personal Info, Subscription), Preferences (Settings, Security).
- **Styling:** Grouped ListTiles with section headers (`_buildSectionHeader`).

### 12.4 Dependencies Snapshot
- `flutter`: SDK
- `file_picker`: ^10.3.9 (File uploads)
- `serverpod_flutter`: (Backend connection)

## 13. Implementation & Architecture Decisions (v1.0-alpha)

### 13.1 Authentication & Security
- **Strict Ownership:** All sensitive data access (Documents, Chat History) verifies `userId == session.auth.userId`.
- **Public vs Private:** `UserImageEndpoint` allows public read access (for profile avatars) but requires auth for updates/deletes.
- **Client-Side Guardrails:** Client checks `client.auth.isAuthenticated` before making sensitive calls to prevent 401 errors.
- **Type Consistency:** Migrated all Protocol `userId` fields from `int` to `UuidValue` to match Serverpod Auth IDP.

### 13.2 AI & Data Handling
- **Multimodal Pipeline:**
  - Images: Converted to Base64 Data URIs on client -> Decoded on Server -> Sent as `DataPart` to Gemini.
  - DOCX: Text extracted client-side (using `archive` + `xml`) to avoid binary upload overhead/complexity.
- **Robust Parsing:** `GeminiService` uses regex-based JSON extraction to handle Markdown code block wrapping from AI responses.
- **Scoped Caching:** Chat history is cached in Redis with keys prefixed by `userId` to prevent data leakage between users.

### 13.3 Frontend-Backend Integration
- **State Management:** Simple `ValueNotifier` for services (`UserImageService`) to drive UI updates.
- **Web Compatibility:** `ImageCropper` configured with `WebUiSettings` (passing `context`) to ensure Web platform support.

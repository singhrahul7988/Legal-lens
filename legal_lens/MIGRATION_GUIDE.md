# Legal Lens Gemini Migration Guide

This guide details the changes made to migrate the document analysis from a local mock implementation to a real integration with Google's Gemini API via Serverpod.

## 1. API Key Configuration

To enable the Gemini API, you must configure your API key in the server's password file.

**File Location:** `legal_lens_server/config/passwords.yaml`

**Action:**
1. Open `legal_lens_server/config/passwords.yaml`.
2. Locate the `shared:` section.
3. Replace `'YOUR_GEMINI_API_KEY_HERE'` with your actual Gemini API Key.

```yaml
shared:
  mySharedPassword: 'my password'
  geminiApiKey: 'AIzaSy...' # <--- Put your key here
```

*Note: Never commit your actual API key to version control.*

## 2. Execution Instructions

Since changes were made to the Serverpod protocol (`LegalDoc` model), you must regenerate the server code and run migrations before starting the app.

### Step 1: Update Server Protocol & Database
Open a terminal in `legal_lens_server`:

```bash
cd legal_lens_server
# 1. Install dependencies
dart pub get

# 2. Generate Serverpod code (Updates LegalDoc with analysisJson)
serverpod generate

# 3. Create a new database migration
serverpod create-migration

# 4. Apply the migration to the database and start the server
dart run bin/main.dart --apply-migrations
```

*If you don't have the `serverpod` CLI installed globally, you may need to install it via `dart pub global activate serverpod_cli`.*

### Step 2: Run the Client
Open a new terminal in `legal_lens_flutter`:

```bash
cd legal_lens_flutter
flutter run
```

## 3. Expected Behaviors & Debugging

### Analysis Flow
1. **Upload**: When you pick a file in the app, it is read locally.
2. **Creation**: The app sends the content to the server (`createDocument`).
3. **Analysis**: The app requests analysis (`analyzeDocument`).
4. **Processing**:
   - The server reads the content.
   - It sends a prompt to Gemini asking for a JSON response with risk scores, red flags, and summaries.
   - Gemini returns the JSON.
   - The server stores the JSON in `LegalDoc.analysisJson`.
5. **Result**: The app receives the updated `LegalDoc`, parses the JSON, and displays the "Risk Score", "Red Flags", and "Summary" in the dashboard.

### Success Indicators
- The "Risk Score" gauge updates from 0 to a real value (e.g., 85/100).
- The "Summary" section contains specific details about the document text you uploaded.
- "Red Flags" list specific clauses from the document.

### Error Handling
- **"Gemini API Key not configured"**: Check `passwords.yaml`.
- **"Analysis failed or returned empty"**: The document content might be too short or Gemini refused to process it. Check the server logs.
- **Connection Refused**: Ensure the server is running on port 8080.

### Debugging
If analysis fails, check the server console (Terminal 1). It will log the specific error from Gemini (e.g., `Quota exceeded`, `Invalid Argument`).

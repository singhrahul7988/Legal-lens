BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "legal_doc" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "originalFileUrl" text,
    "content" text,
    "summary" text,
    "status" text NOT NULL,
    "type" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR legal_lens
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('legal_lens', '20260127152924461', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260127152924461', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;

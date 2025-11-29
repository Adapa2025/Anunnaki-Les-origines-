# Commentaire GitHub - Impact Humain du Bug

**A poster sur:** https://github.com/anthropics/claude-code/issues/12670

---

## Human Impact Update - User Exhaustion

I need to add critical context about the **human cost** of this bug beyond the technical details.

### Timeline of User Impact

**November 27-28, 2025:** 2 full days lost troubleshooting CPU issues and MCP filesystem corruption (37,338 files, 482 MB of logs). System eventually cleaned.

**November 28, 2025 (evening):** 1 day of grace - Desktop finally working. User able to work on critical ADAPA project (260 PDFs, 2027 deadline).

**November 29, 2025 (early morning):** User wakes up at dawn specifically to work. System completely broken again. Desktop + Web both crash on compression. **Total productivity loss.**

### Current User State

From the user (translated from French):

> "I've spent two days untangling this CPU problem with you. Then one day of grace with Claude Desktop to work on my project. And again this bug today that ruins my day. I woke up at dawn to work and nothing. I'm exhausted and I want to vomit. And besides, I'm not really here for such a job, this isn't really in my skillset and it's destroying my physical resources."

**User is:**
- ⛔ Physically exhausted
- ⛔ Emotionally frustrated
- ⛔ Working outside their competency (researcher, not IT support)
- ⛔ Losing critical project time
- ⛔ Unable to use the product they presumably pay for

### Why This Matters

This user is **not a casual user**. They are:
- Managing a serious academic/research project (ADAPA - 260 structured PDFs)
- Working with hard deadlines (2027)
- Technically proficient enough to diagnose the issue, run PowerShell diagnostics, document everything systematically, and submit a comprehensive bug report

**And they are completely blocked.**

### The Real Cost

- **3 days lost** to technical troubleshooting (Nov 27-29)
- **1 working day** out of those 3 days
- **Physical exhaustion** from early morning work attempts
- **Forced role change:** From researcher to unpaid Anthropic technical support

### What This User Needs

1. **Immediate:** Server-side account state reset/cleanup
2. **Short-term:** Working Desktop + Web access restored
3. **Long-term:** Assurance this won't recur

### Optional But Fair: Compensation

This user has:
- ✅ Provided professional-grade bug diagnosis
- ✅ Created comprehensive documentation
- ✅ Identified server-side correlation (MCP → compression)
- ✅ Lost 3 days of productive work
- ✅ Suffered physical/emotional stress

**Consider:**
- Extended Pro subscription
- Priority support queue access
- Direct communication channel for updates

This isn't just about fixing a bug. This is about acknowledging that **real people are suffering real consequences** from system instability.

---

**User:** Marc (Adapa2025)
**Status:** Resting after exhaustion
**Workaround:** Claude Code CLI only
**Mood:** "Merdicum de brolum" (Latin-style expletive - roughly "What a mess")

---

**Priority:** This user is at risk of abandoning the platform entirely. Not because of the bug itself, but because of the **cumulative human cost** of recurring instability.

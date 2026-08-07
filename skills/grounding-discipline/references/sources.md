# Grounding discipline — research sources

Synthesized 2026-08-07 for AI-Tools. Not exhaustive; prefer primary docs when updating.

## Standards and risk frameworks

- NIST AI RMF 1.0 — https://doi.org/10.6028/NIST.AI.100-1  
- NIST GenAI Profile (confabulation) — https://doi.org/10.6028/NIST.AI.600-1  
- OWASP LLM09:2025 Misinformation — https://genai.owasp.org/llmrisk/llm092025-misinformation/

## Vendor guidance

- Anthropic — reduce hallucinations (abstain, quote-first, cite/retract) — https://platform.claude.com/docs/en/test-and-evaluate/strengthen-guardrails/reduce-hallucinations  
- OpenAI — why language models hallucinate — https://openai.com/index/why-language-models-hallucinate/  
- Google Cloud — grounding overview — https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/grounding/overview  
- Google — check grounding API — https://docs.cloud.google.com/generative-ai-app-builder/docs/check-grounding  

## Agent / engineering practice

- Anthropic — building effective agents — https://www.anthropic.com/engineering/building-effective-agents  
- Cursor — agent best practices — https://cursor.com/blog/agent-best-practices  
- Microsoft — mitigating LLM hallucinations — https://techcommunity.microsoft.com/blog/azure-ai-foundry-blog/best-practices-for-mitigating-hallucinations-in-large-language-models-llms/4403129  

## Patterns and metrics

- Chain-of-Verification (CoVe) — https://arxiv.org/abs/2309.11495  
- SelfCheckGPT — https://arxiv.org/abs/2303.08896  
- RAGAS faithfulness — https://docs.ragas.io/en/stable/concepts/metrics/available_metrics/faithfulness/  
- Source inventory (MindStudio) — https://www.mindstudio.ai/blog/source-inventory-ai-agent-anti-hallucination  
- Volere Ten Tests for requirements — https://www.volere.org/ten-tests-for-requirements/  
- Superpowers (evidence over claims, hard gates) — https://github.com/obra/superpowers  
- giasip ClaimCards / claim ledger — https://github.com/GiaSip/giasip-skills  
- grounded-research-skill — https://github.com/arturseo-geo/grounded-research-skill  

## Requirements elicitation (reuse, don’t reinvent)

- IEEE/ISO/IEC 29148 requirements engineering  
- Interactive agents for ambiguity in SE — https://arxiv.org/html/2502.13069v1  

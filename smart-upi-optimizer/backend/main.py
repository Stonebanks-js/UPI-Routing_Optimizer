from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from backend.routers import transactions, recommendations, stats

app = FastAPI(
    title="Smart UPI Routing Optimizer",
    description="A recommendation engine that sits on top of UPI routing, tracks latency strings across installed tools, and recommends the best-performing API hook layer.",
    version="1.0.0"
)

# Standard permissive CORS layer allowing all standard methods
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount endpoints mapping internal routers to outward facing paths
app.include_router(transactions.router, prefix="/transactions", tags=["Transactions"])
app.include_router(recommendations.router, prefix="/recommendations", tags=["Recommendations"])
app.include_router(stats.router, prefix="/stats", tags=["Statistics"])

@app.on_event("startup")
async def startup_event():
    """
    Called strictly once on startup matching user visibility parameters.
    """
    print("UPI Optimizer backend is running")

@app.get(
    "/",
    summary="Root Entrance Endpoint",
    description="Provides baseline app ping to prove API routing binds."
)
def root_endpoint():
    return {"message": "Smart UPI Routing Optimizer API"}

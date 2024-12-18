from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from pathlib import Path
import asyncio
import json

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace "*" with specific origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


FILE_PATH = "data.txt"
Path(FILE_PATH).touch(exist_ok=True)  # Ensure the file exists
clients = []


class WriteRequest(BaseModel):
    eventType: str
    email: str
    details: str
    timestamp: str
    ipAddress: str


@app.get("/read-file")
async def read_file():
    """Reads the content of the TXT file."""
    try:
        with open(FILE_PATH, "r") as file:
            content = file.readlines()
        return {"content": content}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error reading file: {str(e)}")


@app.post("/write-file")
async def write_file(request: WriteRequest):
    """Writes a line to the TXT file."""
    try:
        json_data = json.dumps(request.dict())
        with open(FILE_PATH, "a") as file:
            file.write(json_data + "\n")
        # Notify WebSocket clients about changes
        for client in clients:
            await client.send_text(json_data)
        return {"message": "Data added successfully!"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error writing to file: {str(e)}")


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint to stream live data to clients."""
    await websocket.accept()
    clients.append(websocket)
    try:
        while True:
            await websocket.receive_text()  # Keep connection alive
    except WebSocketDisconnect:
        clients.remove(websocket)

---@meta

--#region Type Definitions

---Represents match and server context information.
---@class Context
---@field match_id string
---@field node string
---@field vars table

---Represents a user in the match.
---@class Presence
---@field user_id string User's unique ID.
---@field session_id string Session ID of the user's connection.
---@field username string User's unique username.
---@field node string Name of the Nakama node the user is connected to.

---Represents a data message from a client.
---@class Message
---@field sender Presence Sender of the message.
---@field op_code number Numeric opcode set by the sender.
---@field data string|nil Arbitrary data payload sent by the sender.

---Dispatcher object used to send messages to match participants.
---@class Dispatcher
---@field broadcast_message fun(op_code: number, data: string, presences: Presence[])

--#endregion

--#region Match Functions

---Called once when a match is created. Sets up the initial state of the match.
---@param ctx Context The context object representing match and server info.
---@param params table Optional second argument passed to `match_create()`, or nil.
---@return table state Initial in-memory match state. Non-nil Lua term or nil to end match.
---@return number tick_rate Tick rate (1–60) controlling match_loop() calls per second.
---@return string label Label used for filtering in match listing (0–2048 bytes).
function match_init(ctx, params) end

---Called when users complete the join process and are ready to receive match data.
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param presences Presence[] List of users who joined the match.
---@return table state Updated match state or nil to end match.
function match_join(ctx, dispatcher, tick, state, presences) end

---Called when a user attempts to join a match.
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param presence Presence The user attempting to join.
---@param metadata table Arbitrary key-value pairs sent with the join request.
---@return table state Updated match state or nil to end match.
---@return boolean accepted True if the join should be accepted, false otherwise.
---@return string? reject_message Optional rejection reason string.
function match_join_attempt(ctx, dispatcher, tick, state, presence, metadata) end

---Called when users leave the match, including due to connection loss.
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param presences Presence[] List of users who left the match.
---@return table state Updated match state or nil to end match.
function match_leave(ctx, dispatcher, tick, state, presences) end

---Executed every tick (as set in `match_init`) to process logic and client messages.
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param messages Message[] List of data messages received since last tick.
---@return table state Updated match state or nil to end match.
function match_loop(ctx, dispatcher, tick, state, messages) end

---Called when the match handler receives a runtime signal (e.g. for reservations).
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param data string Arbitrary input string supplied by the runtime signal.
---@return table state Updated match state or nil to end match.
---@return string|nil response Arbitrary response string for the signal caller.
function match_signal(ctx, dispatcher, tick, state, data) end

---Called when the server begins a graceful shutdown and wants to terminate the match.
---@param ctx Context The context object representing match and server info.
---@param dispatcher Dispatcher Dispatcher object for sending messages.
---@param tick number Current tick count, starts at 0 and increments after each match_loop.
---@param state table Current in-memory match state.
---@param grace_seconds number Seconds allowed to gracefully end the match before forced close.
---@return table state Updated match state or nil to end match.
function match_terminate(ctx, dispatcher, tick, state, grace_seconds) end

--#endregion

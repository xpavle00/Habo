import Foundation

/// Minimal key-value storage; `UserDefaults` conforms.
public protocol KeyValueStore: AnyObject {
    func string(forKey key: String) -> String?
    func integer(forKey key: String) -> Int
    func set(_ value: Any?, forKey key: String)
}

extension UserDefaults: KeyValueStore {}

/// A widget tap waiting for the app to apply it. `code` is the resulting
/// state for `date`, not a toggle, so it stays correct if data changes
/// before the app drains it.
public struct PendingAction: Codable, Equatable, Sendable {
    public let seq: Int
    public let uuid: String
    public let date: LocalDate
    public let code: DayCode
    public let value: Double?
    public let target: Double?
    public let at: String
    /// The state the widget showed for `date` just before the tap. The app
    /// uses it to tell whether the day was changed elsewhere since.
    public let from: DayCode?

    public init(seq: Int, uuid: String, date: LocalDate, code: DayCode, value: Double?, target: Double?, at: String, from: DayCode? = nil) {
        self.seq = seq
        self.uuid = uuid
        self.date = date
        self.code = code
        self.value = value
        self.target = target
        self.at = at
        self.from = from
    }
}

/// Owns `widget_pending_actions` and `widget_pending_seq`. Reads, never
/// writes, the app-owned `widget_applied_seq`.
public struct PendingActionStore {
    private let store: KeyValueStore

    public init(store: KeyValueStore) {
        self.store = store
    }

    private var appliedSeq: Int { store.integer(forKey: SharedKeys.appliedSeq) }

    private func all() -> [PendingAction] {
        guard let raw = store.string(forKey: SharedKeys.pendingActions),
              let list = try? JSONDecoder().decode([PendingAction].self, from: Data(raw.utf8))
        else { return [] }
        return list
    }

    /// Actions not yet applied by the app, in seq order.
    public func pending() -> [PendingAction] {
        let applied = appliedSeq
        return all().filter { $0.seq > applied }.sorted { $0.seq < $1.seq }
    }

    @discardableResult
    public func append(uuid: String, date: LocalDate, code: DayCode, value: Double?, target: Double?, at: Date, from: DayCode? = nil) -> PendingAction {
        let seq = max(store.integer(forKey: SharedKeys.pendingSeq), all().map(\.seq).max() ?? 0) + 1
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        let action = PendingAction(seq: seq, uuid: uuid, date: date, code: code, value: value, target: target, at: formatter.string(from: at), from: from)
        let list = pending() + [action]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        if let data = try? encoder.encode(list), let json = String(data: data, encoding: .utf8) {
            store.set(json, forKey: SharedKeys.pendingActions)
        }
        store.set(seq, forKey: SharedKeys.pendingSeq)
        return action
    }
}

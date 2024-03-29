import Foundation
import Combine

protocol EventsAPIManagerFetcher {
    func getEvents() -> AnyPublisher<[Event], NetworkRequestError>
}

protocol EventsAPIManagerCreator {
    func createEvent(event: Event) -> AnyPublisher<NoReply, NetworkRequestError>
}

protocol EventsAPIManagerUpdater {
    func updateEvent(event: Event) -> AnyPublisher<NoReply, NetworkRequestError>
}

protocol EventsAPIDeletor {
    func deleteEvent(with id: String) -> AnyPublisher<NoReply, NetworkRequestError>
}

protocol EventsAPIManager: EventsAPIManagerFetcher, EventsAPIManagerCreator, EventsAPIDeletor, EventsAPIManagerUpdater {}

final class EventsAPIManagerImpl: EventsAPIManager {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getEvents() -> AnyPublisher<[Event], NetworkRequestError> {
        apiClient.dispatch(GetEventsRequest())
    }
    
    func createEvent(event: Event) -> AnyPublisher<NoReply, NetworkRequestError> {
        apiClient.dispatch(CreateEventRequest(event: event))
    }
    
    func deleteEvent(with id: String) -> AnyPublisher<NoReply, NetworkRequestError> {
        apiClient.dispatch(DeleteEventRequest(id: id))
    }
    
    func updateEvent(event: Event) -> AnyPublisher<NoReply, NetworkRequestError> {
        apiClient.dispatch(UpdateEventRequest(event: event))
    }
}

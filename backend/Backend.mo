import Array "mo:base/Array";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Int "mo:base/Int";
import Time "mo:base/Time";

actor class HelloWorld() {
  stable var names : [Text] = [];
  
  // Add a new name to the list and return personalized greeting
  public func greet(name : Text) : async Text {
    if (Text.size(name) == 0) {
      return "Please provide a valid name!";
    };

    names := Array.append(names, [name]);
    return generateGreeting(name);
  };

  // Get all submitted names
  public query func getSubmittedNames() : async [Text] {
    names;
  };

  // Get total number of greetings
  public query func getTotalGreetings() : async Nat {
    names.size();
  };

  // Search for names containing a substring
  public query func searchNames(term : Text) : async [Text] {
    let matchingNames = Buffer.Buffer<Text>(0);
    for (name in names.vals()) {
      if (Text.contains(name, #text term)) {
        matchingNames.add(name);
      };
    };
    Buffer.toArray(matchingNames);
  };

  // Clear all names
  public func clearNames() : async () {
    names := [];
  };

  // Helper function to generate greeting message
  private func generateGreeting(name : Text) : Text {
    let greetings = ["Hello", "Hi", "Hey", "Greetings"];
    let randomIndex = Int.abs(Time.now()) % greetings.size();
    return greetings[randomIndex] # ", " # name # "! Welcome to our community!";
  };
};

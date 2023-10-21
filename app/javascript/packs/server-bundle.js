import ReactOnRails from "react-on-rails";

import HelloWorld from "../bundles/HelloWorld/components/HelloWorldServer";
import Notification from "../bundles/Notification/components/NotificationServer";
import PricesEvolution from "../bundles/PricesEvolution/components/PricesEvolution";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  Notification,
  PricesEvolution,
});

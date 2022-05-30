using {TravelService} from '../srv/travel-service';

annotate TravelService.Travel with @odata.draft.enabled;
//Add Semantic key
annotate TravelService.Travel with @Common.SemanticKey: [TravelID];


//Add Aggregation Capabilities

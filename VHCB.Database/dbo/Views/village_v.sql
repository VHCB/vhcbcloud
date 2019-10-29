create view village_v as
select v.VillageID, V.Village, tc.Zip, tc.LkTown, tc.Town
from village v(nolock)
join towncounty tc(nolock) on v.VillageID = tc.VillageID
where isnull(tc.Zip, '') != ''
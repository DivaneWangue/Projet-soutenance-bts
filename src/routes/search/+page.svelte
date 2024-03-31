<script lang="ts">
    import type { PageData } from "./$types";
    import { page } from "$app/stores";

    export let data: PageData;
</script>

<svelte:head>
    <title
        >Recherche des prix pour: {$page.url.searchParams.get("s")} dans différents
        supermarchés</title
    >
</svelte:head>

<div>
    <div class="mt-8 mb-20 pb-5 bg-white rounded-lg px-4">
        <div class="flex justify-between items-center my-3">
            <p class=" text-lg font-semibold text-gray-700">
                Resultas de recherche pour "{$page.url.searchParams.get("s")}"
            </p>
        </div>
        <div class="overflow-x-auto">
            <table class="table">
                <!-- head -->
                <thead>
                    <tr>
                        <th>Nom produit</th>
                        <th>Supermarche</th>
                        <th>Prix</th>
                    </tr>
                </thead>
                <tbody>
                    {#await data.data}
                        {#each Array.from({ length: 10 }, (_, i) => i + 1) as item}
                            <tr class="hover">
                                <td>
                                    <div class="flex items-center gap-3">
                                        <div class="avatar">
                                            <div
                                                class="skeleton mask mask-squircle w-12 h-12"
                                            ></div>
                                        </div>
                                        <div class="w-12 space-y-2">
                                            <div class="skeleton h-2"></div>
                                            <div
                                                class="skeleton h-2 w-8 text-sm opacity-50"
                                            ></div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div>
                                        <div class="skeleton h-3 w-20"></div>
                                    </div>
                                </td>
                                <td>
                                    <div>
                                        <div class="skeleton h-3 w-20"></div>
                                    </div>
                                </td>
                            </tr>
                        {/each}
                    {:then prices}
                        {#if prices.length === 0}
                            <tr>
                                <td colspan="3" class="text-center">
                                    <div class="flex w-full justify-center">
                                        <div class="w-48 mask mask-squircle">
                                            <img
                                                src="/noresult.png"
                                                alt="no result"
                                            />
                                        </div>
                                    </div>
                                    <div class="text-2xl">
                                        Aucun resultat trouvé pour "
                                        {$page.url.searchParams.get("s")}"
                                    </div>
                                </td>
                            </tr>
                        {/if}
                        {#each prices as price}
                            <tr class="hover">
                                <td>
                                    <div class="flex items-center gap-3">
                                        <div class="avatar">
                                            {#if price.produit.imageUrl}
                                                <div
                                                    class="w-24 mask mask-squircle"
                                                >
                                                    <img
                                                        src={price.produit
                                                            .imageUrl}
                                                        alt={price.produit.name}
                                                    />
                                                </div>
                                            {:else}
                                                <div
                                                    class=" bg-slate-500 mask mask-hexagon-2 w-12 h-12"
                                                ></div>
                                            {/if}
                                        </div>
                                        <div class=" space-y-4">
                                            <div class="w-full h-2 text-lg">
                                                {price.produit.name}
                                            </div>
                                            <div
                                                class=" h-2 w-full opacity-50 text-lg"
                                            >
                                                {price.produit.fabricant ??
                                                    "Fabricant Inconnu"}
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <!-- Supermarche -->
                                    <div>
                                        <div class="h-3 w-auto text-lg">
                                            {price.supermarche.name}
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <!-- Prix -->
                                    <div>
                                        <div class="h-3 w-20 font-bold text-lg">
                                            {price.prix} FCFA
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        {/each}
                    {/await}
                </tbody>
                <!-- foot -->
                <tfoot>
                    <th>Nom produit</th>
                    <th>Supermarche</th>
                    <th>Prix</th>
                </tfoot>
            </table>
        </div>
    </div>
</div>

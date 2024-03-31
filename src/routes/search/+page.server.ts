import prisma from '$lib/prisma';
import type { PageServerLoad } from './$types';

export const load = (async ({ params, url }) => {

    const request = url.searchParams.get('s') ? prisma.prix.findMany({
        where: {
            produit: {
                name: { contains: url.searchParams.get('s') ?? "", mode: 'insensitive' }
            },

        },
        select: { idprod: true, prix: true, produit: { select: { name: true, barecode: true, fabricant: true, imageUrl: true } }, supermarche: { select: { name: true, } } }
    }) : prisma.prix.findMany({
        where: {

            produit: {
                barecode: { equals: url.searchParams.get('code') ?? "", mode: 'insensitive' }
            },

        },
        select: { idprod: true, prix: true, produit: { select: { name: true, barecode: true, fabricant: true, imageUrl: true } }, supermarche: { select: { name: true, } } }
    })


    return {
        data: request,
    };
}) satisfies PageServerLoad;